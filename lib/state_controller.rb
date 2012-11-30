module TincanSinatra
	class StateController < BaseController

		def get
			registration.state(state_id)
		end

		def put
			ap params
			"OK"
		end

		def post
			ap params
			"OK"
		end

		def delete
			ap params
			"OK"
		end

	end
end