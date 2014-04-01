ENV['RACK_ENV'] = 'test'
require 'minitest/autorun'
require 'rack/test'
require 'minitest/spec'
require 'minitest/autorun'

#require '../config.ru'


include Rack::Test::Methods

#include Rack::Test::Methods
#require File.expand_path '../apps/users.app.rb', __FILE__
