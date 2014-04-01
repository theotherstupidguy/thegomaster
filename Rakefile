require 'rake/testtask'
Rake::TestTask.new do |t|
  #t.libs << File.expand_path('config.ru', __FILE__)
  #t.libs << "apps/users/models/gouser.rb"
  t.libs << "apps/users/app.rb"
  #t.libs << "config.ru"
  t.libs << "specs"
  #t.pattern = "specs/*_spec.rb"
  #t.pattern = "apps/*/app.rb"
  #t.pattern = "apps/users/models/gouser.rb"
  t.pattern = "apps/users/app.rb"
  t.pattern = "apps/*/models/*.rb"


  #t.libs.push << "config.ru"
  #t.libs.push << "apps/users/app.rb"
  t.pattern = "specs/*_spec.rb"
  #t.test_files = FileList['spec/*_spec.rb']
  #t.libs.push << "specs/*_spec.rb"
  t.verbose = true
end

# seed Games  
# crawel internet for sgf and iditidfy it and store it 
#Rake::Task.new do |t|
#
#end

## setup test environment
# set :environment, :test
# set :run, false
# set :raise_errors, true
# set :logging, false

task :seed do
    ruby "./jobs/populate.rb"
end

task :crawler do
    ruby "jobs/noko"
end

task :www_comments_aggregation => :crawler do
    ruby "jobs/sgf"
end

task :console do
  require 'pry'
  #require 'irb'
  #require 'irb/completion'
  #TODO load gemfile list automatically
  require 'sinatra/base' # You know what to do.
  #ARGV.clear
  #IRB.start
  pry.start
end
