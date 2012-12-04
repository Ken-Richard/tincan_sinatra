require File.dirname(__FILE__) + '/../lib/tincan_sinatra.rb'
require File.dirname(__FILE__) + '/../lib/registration.rb'

require 'rspec'
require 'rack/test'

set :environment, :test

describe 'API Basics' do
  include Rack::Test::Methods

  def app
    TincanSinatra::Server
  end

  it "provides CORS options" do
    options '/TCAPI/activities/state?method=GET'
    last_response.should be_ok
    last_response.headers["Access-Control-Allow-Origin"].should eq("http://s3.amazonaws.com")
    last_response.headers["Access-Control-Allow-Methods"].should eq("GET,POST,PUT,DELETE")
    last_response.headers["Access-Control-Allow-Headers"].should eq("Origin,Accept,Content-Type,X-Requested-With,X-CSRF-Token")
    last_response.headers["Access-Control-Allow-Credentials"].should eq("true")
  end

  context "given a registration" do

    it "allows internet explorer style CORS transactions" do

      TincanSinatra::Registration.register('9999999999')

    	# GET - IE Style
      post "/TCAPI/activities/state?method=GET&registration=1", "registration" => "9999999999"
      last_response.should be_ok

      # GET - Normal Style
      get "/TCAPI/activities/state?registration=9999999999"
      last_response.should be_ok

    end
  end

end


describe 'The State API' do

  include Rack::Test::Methods

  def app
    TincanSinatra::Server
  end

  before(:each) do
    @registration = TincanSinatra::Registration.register('12345')
  end

  it "returns an error when the registration parameter is not provided" do
    post "/TCAPI/activities/state?method=GET"
    last_response.should be_bad_request
  end

  it "returns an error when the registration parameter is not found" do
    get "/TCAPI/activities/state?registration=54321"
    last_response.should be_not_found
  end

  it "does not support post" do
    post "/TCAPI/activities/state", "registration=54321"
    last_response.should be_method_not_allowed
  end

  context "with no state data" do

    it "it returns a blank state array" do
      post "/TCAPI/activities/state?method=GET&registration=12345"
      last_response.should be_ok
      last_response.content_type.should include('application/json')
      last_response.body.should eq('[]')
    end

    it "returns 404 when data for an state id doesn't exist" do
      post "/TCAPI/activities/state?method=GET", {
        'registration' => 12345,
        'stateId' => 67890
      }
      last_response.should be_not_found
    end

    it "can save state data" do
      post "/TCAPI/activities/state?method=PUT", {
        'registration' => '12345',
        'stateId' => '67890',
        'content' => 'my-state-data'
      }
      last_response.status.should eq(204)
    end

    it "can delete specific state data" do
      @registration.save_state('key1','value1')
      @registration.save_state('key2','value2')
      @registration.state(nil).should eq(['key1','key2'])
      post "/TCAPI/activities/state?method=DELETE", {
        'registration' => '12345',
        'stateId' => 'key1'
      }
      last_response.status.should eq(204)      
      @registration.state(nil).should eq(['key2'])
    end

    it "can delete all state data" do
      @registration.save_state('key1','value1')
      @registration.save_state('key2','value2')
      @registration.state(nil).should eq(['key1','key2'])
      post "/TCAPI/activities/state?method=DELETE", {
        'registration' => '12345'
      }
      last_response.status.should eq(204)      
      @registration.state(nil).should eq([])
    end

  end

end



describe 'The Statement API' do
  
  include Rack::Test::Methods

  def app
    TincanSinatra::Server
  end

  before(:each) do
    @registration = TincanSinatra::Registration.register('12345')
  end

  it "can save a statement" do

    content = {

    }
    
    post "/TCAPI/activities/state?method=DELETE", {
      'registration' => '12345',

    }
   end

end