require 'sinatra/base'
require "sinatra/config_file"
require 'mongoid'
require 'sprockets'
#require 'rack/attack'
#require 'geoip'


require './apps/users/app'
require './apps/tips/app'
require './apps/games/app'
require './apps/studies/app'

Mongoid.load!(File.expand_path(File.join("config", "mongoid.yml")))


use Users 
use Tips 
use Games 
use Studies

#use Rack::Attack

# Always allow requests from localhost
# # (blacklist & throttles are skipped)
#Rack::Attack.whitelist('allow from localhost') do |req|
  # Requests are allowed if the return value is truthy
#  '127.0.0.1' == req.ip
#end

#Rack::Attack.whitelist('allow from japan') do |req|
  # Requests are allowed if the return value is truthy
#  GeoIP.new('GeoIP.dat').country(req.ip).country_code2 == 'JP'
#end

# Throttle requests to 5 requests per second per ip
#Rack::Attack.throttle('req/ip', :limit => 15, :period => 1.second) do |req|
  # If the return value is truthy, the cache key for the return value
  # is incremented and compared with the limit. In this case:
  #   "rack::attack:#{Time.now.to_i/1.second}:req/ip:#{req.ip}"
  #
  # If falsy, the cache key is neither incremented nor checked.
#  req.ip
#end

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
