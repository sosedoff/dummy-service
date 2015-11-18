require "bundler/setup"
require "rack/heartbeat"
require "./app.rb"

use Rack::Heartbeat
run Sinatra::Application