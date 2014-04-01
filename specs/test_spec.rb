#require File.expand_path './test_helper.rb', __FILE__
require 'test_helper.rb'

ENV['RACK_ENV'] = 'test'

#require 'hello_world'  # <-- your sinatra app
#require 'test/spec'
#require "rack-minitest/test"
#require 'rack/test'
#require 'minitest/autorun'
#require 'minitest/spec'

#load '../config.ru'
#require '../apps/users/app'



describe "Users" do
  subject { Users.new }

  def app
    Users.new
  end

  it "should successfully return a Hi" do
    get '/' 
    assert last_response.ok?
    assert_equal 'Hi', last_response.body 
  end
end
