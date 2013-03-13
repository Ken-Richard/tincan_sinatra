require File.dirname(__FILE__) + '/base_model'

module TincanSinatra
  class Activity < BaseModel

    def self.factory_create
      Activity.new
    end

  end
end
