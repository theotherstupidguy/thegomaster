class GoTip
  include Mongoid::Document
  field :title, type: String
  field :sgf, type: String
  field :desc, type: String
  # has many moves and each move has a comment
end
