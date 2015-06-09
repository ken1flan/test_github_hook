$:.unshift File.dirname(__FILE__)

require "sinatra"
require "github"

configure :production, :development do
  enable :logging
end

get "/" do
  "hello, world!"
end

post "/github" do
  Github::hello(params)
  logger.info "payload:" + params[:payload].to_s
  payload = JSON.parse(params[:payload])
  logger.info "payload:" + payload['repository']['name']
end
