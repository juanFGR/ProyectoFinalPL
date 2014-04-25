$:.unshift "."
require 'sinatra'
require "sinatra/reloader" if development?
require 'sinatra/flash'
require 'pl0_program'
require 'auth'
require 'pp'

enable :sessions
set :session_secret, '*&(^#234)'
set :reserved_words, %w{grammar test login auth}
set :max_files, 8        # no more than max_files+1 will be saved

helpers do
  def current?(path='/')
    (request.path==path || request.path==path+'/') ? 'class = "current"' : ''
  end
end

get '/grammar' do
  erb :grammar
end

get '/tests' do
  erb :tests
end

get '/:selected?' do |selected|
  p = User.all
  programs = p.program.all
  pp programs
  puts "selected = #{selected}"
  c  = p.program.first(:name => selected)
  source = if c then c.source else "a = 3-2-1; ." end
  erb :index, 
      :locals => { :programs => programs, :source => source }
end

post '/save' do
  pp params
  name = params[:fname]
  if session[:auth] # authenticated
    if settings.reserved_words.include? name  # check it on the client side
      flash[:notice] = 
        %Q{<div class="error">No se puede guardar el archivo '#{name}'.</div>}
      redirect back
    else 
      p = User.first(:user => session[:name])
      if p # Si existe ese usuario
        c = p.program.first(:name => name)
        if c # Si existe el programa del usuario lo borro y creo el nuevo
          c.destroy
          c = p.program.new
          c.attributes = {
            :name => params["fname"], 
            :source => params["input"]}
          c.save
        else 
         # Si ese programa no lo tiene el usuario pero lo tiene algun otro usuario también lo borro
          c1 = User.all
          c1 = c1.program.first(:name => name)
          if c1
            c1.destroy
          end
          if Program.all.size >= settings.max_files
            c = Program.all.sample
            c.destroy
          end
          c = User.first(:user => session[:name])
          c1 = c.program.new
          c1.attributes = {
            :name => params["fname"], 
            :source => params["input"]}
          c = c1
          c.save
        end
        flash[:notice] = 
          %Q{<div class="success">Archivo #{c.name} guardado por #{session[:name]}.</div>}
        pp c
        redirect to '/'+name
      else # Si no existe ese usuario
        c = User.new
        c.attributes = {:user => session[:name] }
        if Program.all.size >= settings.max_files
          c = Program.all.sample
          c.destroy
        end
        c = c.program.new
        c.attributes = {
          :name => params["fname"], 
          :source => params["input"]}
        c.save
        flash[:notice] = 
          %Q{<div class="success">Archivo #{c.name} guardado por #{session[:name]}.</div>}
        pp c
        redirect to '/'+name
      end
    end
  else
    flash[:notice] = 
      %Q{<div class="error">Para guardar debes autentificarte con Google o Github.<br />
         </div>}
    redirect back
  end
end

post '/userprograms' do
  pp params
  userName = params[:fname]
  p = User.first(:user => userName)
  
  if p
    programs = p.program.all
    puts programs
    pp programs
    c  = p.program.first
    source = if c then c.source else "a = 3-2-1; ." end
    if programs.count == 0
      flash[:notice] = 
        %Q{<div class="error">Ese usuario no tiene programas almacenados.<br /> </div>}
      redirect back
    else
      erb :index, 
          :locals => { :programs => programs, :source => source }  
    end
  else
    flash[:notice] = 
      %Q{<div class="error">Ese usuario no existe en la base de datos.<br /></div>}
    redirect back
  end
end
