require "sinatra"
require "json"
require "securerandom"

$request_counter = 0

backend_id = SecureRandom.uuid

def json(data)
  JSON.dump(data)
end

before do
  $request_counter += 1

  headers["X-Backend-Id"] = backend_id
  content_type :json, encoding: "utf-8"
end

get "/" do
  json(
    backend: backend_id,
    request_counter: $request_counter,
    env: Hash[ENV.to_hash.sort_by { |k, _| k }]
  )
end

get "/exception" do
  raise "BOOM"
end

get "/exit" do
  exit 1
end

get "/env" do
  json Hash[ENV.to_hash.sort]
end

get "/fs" do
  `ls -al`
end