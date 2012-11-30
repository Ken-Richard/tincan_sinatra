require File.dirname(__FILE__) + '/base_model'

module TincanSinatra
	class Registration < BaseModel

		def self.factory_create
			Registration.new
		end

		def initialize
			@states = {}
		end

		def state(id=nil)
			if id
				@states[id]
			else
				@states.keys
			end
		end

	end
end