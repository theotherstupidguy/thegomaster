=begin
class GoCommentary
  include Mongoid::Document
  #field :authors, type: String
  # each commentary has many authors
  field :body, type: String
  field :rate, type: String
end
=end
