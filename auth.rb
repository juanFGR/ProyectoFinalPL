require 'omniauth-oauth2'
require 'omniauth-google-oauth2'
require 'omniauth-github'
require 'omniauth-facebook'
require 'omniauth-twitter'


use OmniAuth::Builder do
  config = YAML.load_file 'config/config.yml'
  provider :google_oauth2, config['identifier'], config['secret']
  provider :github, config['identifierGH'], config['secretGH']
  provider :facebook, config['identifierFB'], config['secretFB']
  provider :twitter, config['identifierTW'], config['secretTW']
end



get '/auth/:name/callback' do
  session[:auth] = @auth = request.env['omniauth.auth']
  session[:name] = @auth['info'].name
  session[:image] = @auth['info'].image
  flash[:notice] = 
        %Q{<div class="success">Authenticated as #{@auth['info'].name}.</div>}
  redirect '/'
end



get '/auth/failure' do
  flash[:notice] = params[:message] 
  redirect '/'
end
