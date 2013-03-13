require File.dirname(__FILE__) + '/base_model'

module TincanSinatra
  class Registration < BaseModel

    def self.register(registration_id)
      store(registration_id,Registration.new)
    end

    def self.factory_create
      Registration.new
    end

    def initialize
      @states = {}
    end

    def states
      @states
    end

    def state(id=nil)
      if id
        state = @states[id]
        puts "STATE_ID: #{id} ************$$$$$$"
        raise NotFoundException unless state
        state
      else
        @states.keys
      end
    end

    def save_state(id,data)
      @states[id] = data
    end

    def delete_state(id)
      if id==nil
        @states = {}
      else
        @states.delete(id)
      end
    end

  end
end
