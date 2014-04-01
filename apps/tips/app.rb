require File.dirname(__FILE__) + "/models/gotip.rb"

class Tips < Sinatra::Base
  #  get '/addtip' do 
  #    erb :addtip
  #  end
  get '/mytips' do 
    'all my tips'
  end
  post '/addtip' do 
    env['warden'].authenticate!
    t = GoTip.new
    t.title = params["title"]
    t.desc = params["desc"]
    t.save!

    halt 200, "saved"
    #redirect '/addtip'
    #redirect '#'
  end
end
