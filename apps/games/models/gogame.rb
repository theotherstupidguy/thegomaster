require 'mongoid'
class GoGame 
  include Mongoid::Document
  field :title, type: String
  field :sgf, type: String

  field :viewed, type: Integer 
  field :story, type: String
  field :time, type: Integer
  field :completed, type: Boolean 

  validates :title, uniqueness: true

  field :uploaded_by, type: String 

  #belongs_to :gostudies
  #has_and_belongs_to_many :gostudies
  # has many moves and each move has a comment
end
