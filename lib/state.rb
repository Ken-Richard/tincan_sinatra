require File.dirname(__FILE__) + '/base_model'

module TincanSinatra
  class State < BaseModel

    def self.factory_create
      State.new
    end

  end
end
