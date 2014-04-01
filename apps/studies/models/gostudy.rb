class GoStudy
  include Mongoid::Document

  belongs_to :go_user 

  field :title, type: String
  field :sgf, type: String
  field :viewed, type: Integer 
  field :story, type: String
  field :time, type: Integer
  field :completed, type: Boolean 
 

  #validates :title, uniqueness: true

  #has_one :gogame

  # has many moves and each move has a comment
end
