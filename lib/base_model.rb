module TincanSinatra
  class BaseModel

    def self.find(id)
      @objects = {} unless @objects
      o = @objects[id]
      puts "CANNOT FIND ID=#{id}" unless o
      o
    end

    def self.store(id,o)
      @objects = {} unless @objects
      @objects[id] = o
    end

  end
end
