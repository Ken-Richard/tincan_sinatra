module TincanSinatra
	class BaseController

		attr_accessor :params
		
		def initialize(params)
			self.params = params
		end

		def registration_id
			params["registration"][0]
		end

		def state_id
			params["stateId"][0]
		end

		def actor
			JSON.parse(params["actor"][0])
		end

		## Activity
		def activity_id
			params["activityId"][0]
		end

		def activity
			unless @activity
				@activity = Activity.find(activity_id)
			end
		end

		## Registration
		def registration_id
			p = params["registration"]
			p.kind_of?(Array) ? p[0] : p
		end

		def registration
			unless @registration
				@registration = Registration.find(registration_id)
			end
			@registration
		end

		## State ID
		def state_id
			p = params['stateId']
			p.kind_of?(Array) ? p[0] : p
		end

		def content
			p = params['content']
			p.kind_of?(Array) ? p[0] : p
		end

		## Actor
		def actor
			content = JSON.parse(params['content'][0])
			Actor.new(content['actor'])
		end

		def verb
			content = JSON.parse(params['content'][0])
			content['verb']
		end

	end
end

