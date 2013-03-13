require 'sinatra'
require "sinatra/multi_route"

# Server Base Class
require File.dirname(__FILE__) + '/base_server'

# Exceptions
Dir[File.dirname(__FILE__) + '/exceptions/*.rb'].each {|file| require file }

# Models
require File.dirname(__FILE__) + '/base_model'
require File.dirname(__FILE__) + '/activity'
require File.dirname(__FILE__) + '/registration'
require File.dirname(__FILE__) + '/state'
require File.dirname(__FILE__) + '/actor'

# Controllers
require File.dirname(__FILE__) + '/base_controller'
require File.dirname(__FILE__) + '/statement_controller'
require File.dirname(__FILE__) + '/state_controller'

module TincanSinatra

  class Server < BaseServer

    register Sinatra::MultiRoute

    # TEST REGISTRATION
    Registration.store('b9855f24-2140-4fb8-931d-2a37cf412c2e', Registration.new)


    ##
    ## STATEMENTS
    ##
    route :get, :post, :put, '/TCAPI/statements/' do
      content_type 'application/json'
      process(StatementController)
    end


    ##
    ## ACTIVITIES
    ##
    route :get, :post, :put, :delete, '/TCAPI/activities/state' do
      content_type 'application/json'
      process(StateController)
    end

  end
end
