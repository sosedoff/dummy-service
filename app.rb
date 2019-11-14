require "sinatra"
require "json"
require "securerandom"
require "objspace"

$request_counter = 0
$hostname = `hostname`.strip

backend_id = ENV["BACKEND"] || SecureRandom.uuid

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
    host: $hostname,
    backend: backend_id,
    request_counter: $request_counter,
    env: Hash[ENV.to_hash.sort_by { |k, _| k }],
    pid: Process.pid,
    time: Time.now.to_s,
    headers: request.env.select { |k,_| k.start_with?("HTTP_") },
    cookies: request.cookies
  )
end

get "/health" do
  "OK"
end

get "/exception" do
  raise "BOOM"
end

get "/exit" do
  exit 1
end

get "/realexit" do
  Process.kill "KILL", Process.pid
end

get "/env" do
  json Hash[ENV.to_hash.sort]
end

get "/alloc/:mb" do
  str = "0" * Integer(params[:mb]) * 1024**2
  json(size: str.size)
end

get "/gc" do
  before = ObjectSpace.memsize_of_all
  GC.start
  after = ObjectSpace.memsize_of_all

  json(before: before, after: after, diff: before - after)
end

get "/fs" do
  `ls -al`
end

get "/write" do
  path = params[:path].to_s
  body = params[:body].to_s

  if path.size > 0
    File.open(path, "w") do |f|
      f.write(body)
    end

    json(ok: true)
  else
    json(error: "need path")
  end
end

get "/ping" do
  `ping -c 1 google.com`
end