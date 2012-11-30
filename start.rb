require 'sinatra'
require File.dirname(__FILE__) + '/lib/tincan_sinatra.rb'

TincanSinatra::Server.run!
