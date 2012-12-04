module TincanSinatra
	class StateController < BaseController

		def check_args
			raise MissingArgumentException unless registration_id
			raise NotFoundException unless registration
		end

		def get
			check_args
			registration.state(state_id)
		end

		def put
			check_args
			raise NotFoundException unless state_id
			registration.save_state(state_id, content)
			ap registration.states
			nil
		end

		def delete
			check_args
			registration.delete_state(state_id)
		end

		def post
			raise MethodNotAllowedException
		end

	end
end