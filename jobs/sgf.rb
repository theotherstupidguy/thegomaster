require 'sgf'
parser = SGF::Parser.new
f = File.open('./geek.sgf')
tree = parser.parse f

tree.games # => yields an array of the games contained in the file.
game = tree.games.first # => yields a SGF::Game object, the first in the array, most likely what you care about.

# Commentary Coverage ~ CC-index
cc = 0
game.node_count.times do |m| 
  begin
    node = game.current_node
    p node.properties
    p "############## #{m} #####################"
    #game.next_node
    p node.C
    #node.C = "co-commentary by thegomaster users"
    #tree.save f
    cc = cc + 1
  rescue Exception
    p "EMPTY #{m} EMPTY" 
  ensure 
    game.next_node
  end
  p "Total commented moves = #{cc} out of #{m}, Commentary Coverage = #{( (cc * 100).to_f / (game.node_count * 100).to_f) * 100}"
end