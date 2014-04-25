require 'data_mapper'
# full path!
DataMapper.setup(:default, 
                 ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/database.db" )
class User
  include DataMapper::Resource
  
  property :user, String, :key => true  

  has n, :program 
end

class Program
  include DataMapper::Resource

  property :name, String, :key => true
  property :source, String, :length => 1..1024
  
  belongs_to :user, :required => false
end

DataMapper.finalize
DataMapper.auto_upgrade!


