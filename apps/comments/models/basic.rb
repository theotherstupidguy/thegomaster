=begin
require 'mongoid'

mongo_path = File.expand_path("../../../config/mongoid.yml", __FILE__) #p mongo_path
Mongoid.load!(mongo_path, :development)

module Spotime
  module Core
    module Model
      def self.included(receiver)
	receiver.send :include, Mongoid::Document
	#receiver.send :include, Mongoid::Timestamps
	receiver.send :include, Mongoid::Timestamps::Created
	receiver.send :include, Mongoid::Timestamps::Updated

	receiver.class_eval do
	  field :object, type: String
	  field :livemode, type: Boolean 
	  #"livemode": false,
	  #field :additional_metadata, type: String
	  #validates_presence_of :additional_metadata
	  #Mongoid.logger.level = Logger::DEBUG
	end
      end
    end
  end
end
=end
