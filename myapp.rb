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
  logger.info "X-GitHub-Event:" + request["X-GitHub-Event"]
  logger.info "params:" + params.to_s
  # logger.info "payload:" + params[:payload].to_s

  #request.body.rewind
  #posted_data = request.body.read
  #logger.info "posted_data:" + posted_data.to_s
  #payload = JSON.parse(params[:payload])
  #logger.info "payload:" + payload['repository']['name']
end
