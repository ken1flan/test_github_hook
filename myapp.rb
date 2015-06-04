$:.unshift File.dirname(__FILE__)

require "sinatra"
require "github"

get "/" do
  "hello, world!"
end

get "/github" do
  Github::hello(params)
end
