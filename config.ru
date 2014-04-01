require 'sinatra/base'
require "sinatra/config_file"
require 'mongoid'
require 'sprockets'

require './apps/users/app'
require './apps/tips/app'
require './apps/games/app'
require './apps/studies/app'

Mongoid.load!(File.expand_path(File.join("config", "mongoid.yml")))


use Users 
use Tips 
use Games 
use Studies

['/assets', '/users/assets', '/games/assets','/studies/assets'].each do |app|
  map app do
    environment = Sprockets::Environment.new                                   
    environment.append_path 'ui/assets/' 
    run environment
  end
end

map '/' do 
  run Users 
end
