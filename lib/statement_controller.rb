module TincanSinatra
	class StatementController < BaseController

		def check_args
			raise MissingArgumentException unless statement_id
			raise MissingArgumentException unless registration_id
			raise MissingArgumentException unless verb
			raise MissingArgumentException unless object
			raise MissingArgumentException unless actor
			raise NotFoundException unless registration
		end

		def get
			"OK"
		end

		def put
			# # Must not modify existing per spec
			# raise ConflictException if Statement.find(statement_id)

			# s = Statement.new
			# s.statement_id = statement_id
			# s.verb = verb
			# s.object = object
			# s.registration = registration
			# s.context = context
			# s.actor = actor
			# Statement.store(statement_id,s)

			"OK"
		end

		def post
			"OK"
		end

	end
end