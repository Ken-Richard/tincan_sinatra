module TincanSinatra
	class StatementController < BaseController

		def get
			ap params
			"OK"
		end

		def put
			puts "$$$ ACTOR:#{actor.name} VERB:#{verb}"
			ap params
			"OK"
		end

		def post
			ap params
			"OK"
		end

	end
end