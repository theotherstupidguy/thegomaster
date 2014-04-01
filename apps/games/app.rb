require File.dirname(__FILE__) + "/models/gogame.rb"


class Games < Sinatra::Base
  register Sinatra::ConfigFile
  config_file (File.expand_path(File.join("config", "app.yml")))
  set :views, [File.expand_path(settings.ui), File.expand_path('apps/games/views')]
  helpers do
    def find_template(views, name, engine, &block)
      views.each { |v| super(v, name, engine, &block) }
    end
  end


  get '/games' do
    env['warden'].authenticate!
    @allgames = GoGame.all #somehow exclude the ones in the studies of the envwardenuser._id
    @studies = GoStudy.where(go_user_id: env['warden'].user._id)
    #@games = (@games - @studies).uniq
    @games = []
    @studied = []
    #@games = GoGame.all
    #@studies = GoStudy.where(go_user_id: env['warden'].user._id)
    
    @allgames.each do |game|
      if !@studies.empty?
	@studies.each do |study|
	  if game.title == study.title 
	    p game.title + "will not be added to index"
	    #@games.override.not(title: game.title) 
	    #game.delete
	    @studied << game
	  else 
	    @games << game
	  end
	end
      else 
	@games = @allgames
      end
    end

    if @studied.empty?
      p "populate games.uniq"
      @games = @games.uniq 
      p @games.count
    else 
      p "populate games.uniq - stuided"
      @games = @games.uniq - @studied
      p @games.count
    end
    erb :"index"
  end

  get '/games/:id' do
    env['warden'].authenticate!
    #get '/:id' do
    #@viewed = rand(1...100)
    @game = GoGame.find_by(title: params["id"])
    @game.viewed = @game.viewed + 1
    @game.save!

    @gotips = GoTip.all
    #p @gotips #= GoTip.all
    #@game = GoGame.find_by(title: params[:id])
    erb :"game" #, :layout => :layout
  end

  post '/uploads/game' do
    env['warden'].authenticate!
      File.open('./ui/assets/sgf/' + params['myfile'][:filename], "w") do |f|
	f.write(params['myfile'][:tempfile].read)
      end
      g = GoGame.new
      g.title = File.basename( params['myfile'][:filename], ".*" )
      g.viewed = 0
      g.time = 600 # 10 minutes
      g.completed = false 
      g.uploaded_by = env['warden'].user._id
      g.save
    redirect '/games'
  end

=begin

  post '/uploads/game' do
    env['warden'].authenticate!
    filename = params[:filename]
    if File.extname(filename) == ".sgf"  then 
      #File.write('./ui/assets/sgf/' + filename, filename)
      #File.open('./ui/assets/sgf/' + params[:filename].to_s, 'w+') do |file|
#	file.write(request.body.read)
	#file.write('./ui/assets/sgf/' + filename, request.body.read)
#      end

      File.open('ui/assets/sgf/' + filename, "w") do |f|
	f.write(filename)
      end

      g = GoGame.new
      g.title = File.basename( filename, ".*" )
      g.viewed = 0
      g.time = 600 # 10 minutes
      g.completed = false 
      g.save
    end
    redirect '/'
  end
=end
end
