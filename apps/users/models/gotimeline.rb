#require 'mongoid'
class GoTimeline
  include Mongoid::Document
  include Mongoid::Timestamps

  field :subject, :type => String
  field :predicate, :type => String
  field :object, :type => String
  field :url, :type => String
end
