#require 'bcrypt'
#require 'mongoid'
#require 'sinatra/base'
#require "sinatra/config_file"


#Mongoid.load!(File.expand_path(File.join("config", "mongoid.yml")), :development)
#
#DataMapper.setup(:default, "sqlite://#{Dir.pwd}/db.sqlite")

require 'mongoid'

class GoUser
  include Mongoid::Document
  include Mongoid::Timestamps
  #include BCrypt

  #property :id, Serial, key: true
  #property :username, String, length: 128
  #property :password, BCryptHash
  field :username, :type => String

  field :password, :type => String
  field :email, :type => String

  field :about_me, :type => String

  field :country, :type => String

  #field :goschool_flag, :type => String #honnibo school flag :)


  has_many :go_studies, autosave: true 

  def authenticate(attempted_username, attempted_password)
    user = GoUser.find_by(username: attempted_username)
    if user.username == attempted_username && user.password == attempted_password
      return true
    else
     return  false
    end
=begin
    if self.password == attempted_password
      true
    else
      false
    end
=end
  end
end


# Create a test User
#if User.count == 0
#  @user = User.new
#  @user.username =  "test"
#  @user.password = "test"
#  @user.save
#end
