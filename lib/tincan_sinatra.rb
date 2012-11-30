require 'sinatra'
require "sinatra/multi_route"

# Server Base Class
require File.dirname(__FILE__) + '/base_server'

# Models
require File.dirname(__FILE__) + '/base_model'
require File.dirname(__FILE__) + '/activity'
require File.dirname(__FILE__) + '/registration'
require File.dirname(__FILE__) + '/state'

# Controllers
require File.dirname(__FILE__) + '/base_controller'
require File.dirname(__FILE__) + '/statement_controller'
require File.dirname(__FILE__) + '/state_controller'

module TincanSinatra

	class Server < BaseServer

		register Sinatra::MultiRoute


		##
		## STATEMENTS
		##
		route :get, :post, :put, '/TCAPI/statements/' do
			process(StatementController)
		end


		##
		## ACTIVITIES
		##
		route :get, :post, :put, :delete, '/TCAPI/activities/state' do
			process(StateController)
		end

	end
end
