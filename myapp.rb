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
  repository_name = payload['repository']['name']
  repository_root = ENV["REPOSITORY_ROOT"].to_s
  # logger.info "['repository']['name']" + repository_name
  # logger.info "REPOSITORY_ROOT:" + repository_root

  git_dir = "#{repository_root}/#{repository_name}/.git"
  cmd = "git --git-dir=#{git_dir} remote prune origin" +
        "&& git --git-dir=#{git_dir} fetch origin"
  # pid = Process.spawn(cmd)
  # Process.detach(pid)
  logger.info "COMMAND:" + cmd
end
