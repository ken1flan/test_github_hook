$:.unshift File.dirname(__FILE__)

require "sinatra"
require "github"

get "/" do
  "hello, world!"
end

post "/github" do
  Github::hello(params)
end
