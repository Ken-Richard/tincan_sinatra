require File.dirname(__FILE__) + '/base_model'

module TincanSinatra
  class Actor

    def initialize(data)
      @data = data
    end

    def name
      @data["name"]
    end

  end
end
