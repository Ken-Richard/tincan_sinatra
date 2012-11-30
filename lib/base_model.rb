module TincanSinatra
	class BaseModel

		def self.find(id)
			@objects = {} unless @objects
			o = @objects[id]
			unless o
				o = factory_create
				@objects[id] = o
			end
			o
		end

	end
end