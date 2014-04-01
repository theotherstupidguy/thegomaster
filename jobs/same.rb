require 'sgf'
class GoSensei 
  def initialize(alpha_path, beta_path)
    @alpha_path = alpha_path
    @beta_path = beta_path 
  end
  def same?
    parser = SGF::Parser.new
    f = File.open(@alpha_path)
    tree_a = parser.parse f
    tree_a.games 
    game_a = tree_a.games.first

    f = File.open(@beta_path)
    tree_b = parser.parse f
    tree_b.games 
    game_b = tree_b.games.first 

    alpha = []
    beta = []

    if game_a.node_count == game_b.node_count
      game_a.count.times do |m|
	color = game_a.current_node.properties.to_a[0][0] #[0][1] #[0]
	move = game_a.current_node.properties.to_a[0][1] #[0]
	alpha << [m ,color, move]
	if game_a.respond_to? :properties 
	  game_a.next_node
	end
      end

      game_b.count.times do |m|
	#p "#################### Move #{m} ####################"
	color = game_b.current_node.properties.to_a[0][0] 
	move = game_b.current_node.properties.to_a[0][1]
	beta << [m ,color, move]
	if game_b.respond_to? :properties 
	  game_b.next_node
	end
      end
      #p alpha
      #p beta
      if alpha == beta
	p "both games moves are equal"
	return true
      end

    else
      p "both games moves are NOT equal"
      return false 
    end
  end
end

#f = File.open('./a.sgf')
#s = GoSensei.new('./e.sgf','./d.sgf')
#s.same?

Dir.glob("./*.sgf").each do |a|
  Dir.glob("./*.sgf").each do |b|
    s = GoSensei.new(a,b)
    if s.same?
      p a + 'is equal' + b
    end    
  end
end
