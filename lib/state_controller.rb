module TincanSinatra
	class StateController < BaseController

		def get
			registration.state(state_id)
		end

		def put
		end

		def post
		end

		def delete
		end

	end
end