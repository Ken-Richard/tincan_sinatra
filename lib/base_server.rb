require 'sinatra'
require 'json'
require 'awesome_print'
require 'CGI'

require File.dirname(__FILE__) + '/context'
require File.dirname(__FILE__) + '/registration'

module TincanSinatra
  class BaseServer < Sinatra::Base

    ##
    ## Custom Parameter Parsing
    ##
    ## Storyline uses the alternative tincan rest syntax
    ## for all browsers. They form-encode the parameters
    ## but use a content-type of application/json. We need
    ## to parse the parameters out ourselves
    ##
    def tincan_params

      # Form Encoded Parameters
      raw = request.env["rack.input"].read
      tc_params = CGI::parse(CGI::unescape(raw))

      # Add URL Encoded Parameters
      params.each { |k,v| tc_params[k] = v }

      # Done
      tc_params

    end



    ##
    ## TinCan - The IE alternative syntax (used by all calls for
    ## storyline) is to use POST for everything with a method
    ## param.
    def tincan_verb
      (params[:method] || request.request_method).downcase
    end



    ##
    ## Process a Request
    ##
    def process(controller_class)
      begin
        puts "*** #{controller_class} - #{tincan_verb} *** #{request.url}"
        response = controller_class.new(tincan_params).send(tincan_verb)
        status 204 if ['put','delete'].include?(tincan_verb)
        response ? response.to_json : ""
      rescue MissingArgumentException
        halt 400
      rescue NotFoundException
        halt 404
      rescue MethodNotAllowedException
        halt 405
      end
    end



    ##
    ## add the Cross-Origin Resource Sharing (CORS) headers
    ## add support for the HTTP OPTIONS verb
    ## parse out the tincan parameters
    ##
    before do

      # Cross Origin Support
      response["Access-Control-Allow-Origin"] = "http://s3.amazonaws.com"
      response["Access-Control-Allow-Methods"] = %w{GET POST PUT DELETE}.join(",")
      response["Access-Control-Allow-Headers"] = %w{Origin Accept Content-Type X-Requested-With X-CSRF-Token}.join(",")
      response["Access-Control-Allow-Credentials"] = "true"

      # Handle the options http verb
      if request.request_method == 'OPTIONS'
        halt 200
        return
      end

    end

  end
end
