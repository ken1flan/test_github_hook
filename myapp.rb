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
  # Github::hello(params)
  payload = JSON.parse(params[:payload])
  logger.info "['repository']['name']" + payload['repository']['name']
  repository_name = payload['repository']['name']
  logger.info "REPOSITORY_ROOT:" + ENV["REPOSITORY_ROOT"].to_s
  # git fetch origin
  # git 
end
