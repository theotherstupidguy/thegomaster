require File.dirname(__FILE__) + "/models/gouser.rb"

#require 'rack/flash'
require 'warden'

class Users < Sinatra::Base
  register Sinatra::ConfigFile
  config_file (File.expand_path(File.join("config", "app.yml")))
  set :views, [File.expand_path(settings.ui), File.expand_path('apps/users/views')]
  helpers do
    def find_template(views, name, engine, &block)
      views.each { |v| super(v, name, engine, &block) }
    end
  end



  #set :partials, File.expand_path(settings.partials, 'addtip') 
  #set :views, (File.expand_path(settings.partials, 'addtip'), 'views')
  #set :erb, :layout => :"layouts/layout"
  #set :erb, :layout => :"layouts/layout"
  #set :erb, :layout => :"#{settings.gol}"
  #set :views, [ [File.expand_path(settings.partials)], File.expand_path('apps/users/views')]
  #set :views, [settings.partials, File.expand_path('apps/users/views'), settings.partials]
  #set :views, [settings.partials, 'views']

  #set :views, File.expand_path(settings.gameon_views, __FILE__)
  #set :views, File.expand_path('../../views', __FILE__)
  #set :erb, :views => :"#{settings.gov}"
=begin
  helpers do
    def part(p)
      File.expand_path(File.join("ui/partial", p))
    end
  end
=end
  #configure do
  #set :erb, :layout => :"ui/layouts/layout"

  #  set :erb, :layout => :"../../../ui/layouts/layout"

  #set :erb, :layout_options => { :views => '../../../ui/partials' }
  #set :gv, Proc.new { File.join(root, "../ui/views") }
  #set :erb, :views => :"../../../ui/views"
  #set :views, :views => :"../../../ui/views"
  #set :gv,  :views => :"../../../ui/views" 
  #, :layout => :"../../ui/layouts/layout"
  #end


  use Rack::Session::Cookie, secret: "alanturingcanreadthisupsidedownwhileheisplayinggowith47japanesesamuraioninthedark@Aokigahara"
  #use Rack::Flash, accessorize: [:error, :success]

  use Warden::Manager do |config|
    # Tell Warden how to save our User info into a session.
    # Sessions can only take strings, not Ruby code, we'll store
    # the User's `id`
    config.serialize_into_session{|user| user._id }
    # Now tell Warden how to take what we've stored in the session
    # and get a User from that information.
    config.serialize_from_session{|_id| GoUser.find_by(_id: _id) }

    config.scope_defaults :default,
      # "strategies" is an array of named methods with which to
      # attempt authentication. We have to define this later.
      strategies: [:password],
      # The action is a route to send the user to when
      # warden.authenticate! returns a false answer. We'll show
      # this route below.
      action: 'auth/unauthenticated'
    # When a user tries to log in and cannot, this specifies the
    # app to send the user to.
    config.failure_app = self
  end

  Warden::Manager.before_failure do |env,opts|
    env['REQUEST_METHOD'] = 'POST'
  end

  Warden::Strategies.add(:password) do
    def valid?
      params['user'] && params['user']['username'] && params['user']['password']
    end

    def authenticate!
      user = GoUser.find_by(username: params['user']['username'])
      if user.nil? 
	#|| password.nil?
	fail!("The username you entered does not exist.")
	#flash.error = ""
      elsif user.authenticate(params['user']['username'], params['user']['password'])
	#flash.success = "Successfully Logged In"
	#"Welcome "	
	p "Authenticate:" + user.username
	success!(user)
      else
	fail!("Could not log in")
      end
    end
  end


  post '/auth/signin' do
    env['warden'].authenticate!
    #flash.success = env['warden'].message
    if session[:return_to].nil?
      redirect '/'
    else
      redirect session[:return_to]
    end
  end


  post '/auth/signup' do
    newuser =  GoUser.new
    newuser.username = params['user']['username']
    newuser.password=  params['user']['password']
    newuser.email =  params['user']['email']
    newuser.about_me =  params['user']['about']
    newuser.save!

    env['warden'].authenticate!
    redirect '/'
  end


  get '/auth/signout' do
    env['warden'].raw_session.inspect
    env['warden'].logout
    #flash.success = 'Successfully logged out'
    redirect '/'
  end

  post '/auth/unauthenticated' do
    session[:return_to] = env['warden.options'][:attempted_path]
    puts env['warden.options'][:attempted_path]
    #flash.error = env['warden'].message || "You must log in"
    #redirect '/auth/login'
    redirect '/'
  end

  get '/protected' do
    env['warden'].authenticate!

    erb :protected
  end

  #  get '/' do 
  #    @games = GoGame.all
  #  "somthing like a public timeline, Mark studies GameA, Nona add a tip 'balahblahabalh' and John reached 10hours milestone on game K" 
  #    erb :inde
  #redirect '/games'
  #  end

=begin
  post '/:id/comment' do 
    #TODO g = GoGame.find_by(title: params["id"])
    #TODO get the id of the game an the id of the move then add the comment and save it! 
    p  params["id"]
    p  params[:value]
  end

  post '/games/:id/story' do 
    g = GoGame.find_by(title: params["id"])
    g.story = params[:value]
    g.save
  end
=end

  get '/' do 
    erb :index #, :layout => :"#{settings.gol}"
  end
  ################### User ####################
  get '/users' do
    env['warden'].authenticate!
    @users = GoUser.all
    erb :"users" 
  end

  get '/users/:username' do 
    env['warden'].authenticate!
    @user = GoUser.find_by(username: params[:username])

    if params[:username] == env['warden'].user.username

      p "The user is viewing his own profile page"
      p env['warden'].user.username + " is viewing his own profile"
      @studies = GoStudy.where(go_user_id: env['warden'].user._id)
      @personal_studies = @studies
      @personal = true
    else 
      @personal = false 
      p "The user is viewing another user profile page"
      p env['warden'].user.username + " is viewing " + @user.username + "'s profile"
      @green = []
      @red = []
      @studies = []

      @studies = GoStudy.where(go_user_id: @user._id)
      @my_studies = GoStudy.where(go_user_id: env['warden'].user._id)

      @red = @studies
      if !@my_studies.empty?

	@studies.each do |study|
	  @my_studies.each do |my_study|
	    if study.title == my_study.title 
	      p my_study.title + " will be added to the Green index"
	      @green << my_study 
	      @red = @red - [study]
	    end
	  end
	end
	@green = @green.uniq
	#@red= @red.uniq
	@red = @red.uniq 
      end
      #@red = @studies - @green
      p "green " + @green.count.to_s
      p "red" + @red.count.to_s
    end
    erb :"profile" 
  end

  get '/settings' do 
    env['warden'].authenticate!
    @user = GoUser.find_by(username: env['warden'].user.username)
    erb :"settings" 
  end


  post '/settings/email' do 
    user = GoUser.find_by(username: env['warden'].user.username)
    user.email=  params[:value]
    user.save!
  end

  post '/settings/about' do 
    env['warden'].authenticate!
    user = GoUser.find_by(username: env['warden'].user.username)
    user.about_me = params[:value]
    user.save!
  end
end
