require File.dirname(__FILE__) + "/models/gostudy.rb"

class Studies < Sinatra::Base
  register Sinatra::ConfigFile
  config_file (File.expand_path(File.join("config", "app.yml")))
  set :views, [File.expand_path(settings.ui), File.expand_path('apps/studies/views')]
  helpers do
    def find_template(views, name, engine, &block)
      views.each { |v| super(v, name, engine, &block) }
    end
  end



  get '/studies' do 
    @studies = GoStudy.where(go_user_id: env['warden'].user._id)

    erb :"studies"
  end

  get '/studies/:id' do
    #TODO should be @study instead of @game? review please
    env['warden'].authenticate!
    #@studies = GoStudy.where(go_user_id: env['warden'].user._id)
    @game = GoStudy.find_by(title: params["id"], go_user_id: env['warden'].user._id)
    #@game.viewed = @game.viewed + 1
    @game.inc(:viewed, 1)
    @game.save!

    @gotips = GoTip.all
    erb :"study", :layout => :layout
  end

  post '/studies/:id/time' do 
    #p env['warden'].user.methods 
    #env['warden'].user.password = "shitoo"

    #TODO check if study already exists if not CREATE it
    u = env['warden'].user

    #u.go_studies << (GoStudy.where(title: params["id"]).first_or_initialize).update(time: params[:remaining])
    #u.save!

    #if GoStudy.where(title: params["id"]).exists?
    if GoStudy.where(title: params["id"], go_user_id: u._id).exists?
      u.go_studies << GoStudy.where(title: params["id"]).update(time: params[:remaining])
      u.save!
    p u.username + " keeps studying  " +  params["id"] + GoStudy.where(title: params["id"], go_user_id: u._id).exists?.to_s
    else 
      u.go_studies << GoStudy.new(title: params["id"],time: params[:remaining], viewed: 1)
      u.save!
    p u.username + " starts studying  " +  params["id"] + GoStudy.where(title: params["id"], go_user_id: u._id).exists?.to_s
    end
  end
end
