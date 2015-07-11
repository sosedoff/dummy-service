require "sinatra"
require "json"
require "securerandom"

backend_id = SecureRandom.uuid

def json(data)
  JSON.dump(data)
end

before do
  headers["X-Backend-Id"] = backend_id
  content_type :json, encoding: "utf-8"
end

get "/" do
  json backend: backend_id
end

get "/exception" do
  raise "BOOM"
end

get "/exit" do
  exit 1
end