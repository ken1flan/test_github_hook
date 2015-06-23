require "sinatra"
require "json"

post "/github" do
  payload = JSON.parse(params[:payload])
  repository_name = payload['repository']['name']
  repository_root = ENV["REPOSITORY_ROOT"].to_s
  git_options = "--git-dir=#{repository_root}/#{repository_name}.git"

  if system("pgrep -f \"sh -c git #{git_options}\"")
    next "Found another process for #{repository_name}"
  end

  cmd = "git #{git_options} remote prune origin" +
        " && git #{git_options} fetch origin"
  pid = Process.spawn(cmd)
  Process.detach(pid)
  "Spawn following command: #{cmd}"
end
