require 'mongoid'
#require '../apps/games/models/gogame'
require_relative  '../apps/games/models/gogame'
#require File.expand_path(File.join("../apps/games/models", "gogame"))

Mongoid.load!(File.expand_path(File.join("config", "mongoid.yml")), :development)
#Mongoid.load!(File.expand_path(File.join("../config", "mongoid.yml")), :development)


#g = GoGame.new
#g.title = "shit"
#g.save

#AppRoot = File.expand_path(File.dirname('ui/assets/sgf'))
AppRoot = File.expand_path(('ui/assets/sgf'))

Dir.foreach(AppRoot + '/gobase') do |f|
#Dir.foreach('../ui/assets/sgf/gobase') do |f|
#Dir.foreach('./assets/sgf/shusaku') do |f|
  if File.extname(f) == ".sgf"  then 
    g = GoGame.new
    g.title = File.basename( f, ".*" )
    g.viewed = 0
    g.time = 600 # 10 minutes
    g.completed = false 
    g.save
  end
p 'adds ' + f 
end
p "Done!"

=begin
Dir.foreach('./assets/sgf/famousgames') do |f|
  if File.extname(f) == ".sgf"  then 
    g = GoGame.new
    g.title = File.basename( f, ".*" )
    g.viewed = 0
    g.save
  end
end
=end
