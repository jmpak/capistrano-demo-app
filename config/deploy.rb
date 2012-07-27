set :application, "capistrano-demo-app.jmpak.com"

if ENV['staging']
  set :domain, "staging-capistrano-demo-app.jmpak.com"
else
  set :domain, application
end

set :deploy_via, :remote_cache
set :user, "vagrant"
set :repository,  "https://github.com/jmpak/capistrano-demo-app.git"
set :normalize_asset_timestamps, false

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :deploy_to, "/var/www/apps/#{application}"
role :web, domain                                          # Your HTTP server, Apache/etc
role :app, domain                          # This may be the same as your `Web` server
role :db,  domain, :primary => true # This is where Rails migrations will run

set :runner, user

set :mongrel_servers, 3
set :mongrel_port, 8000
set :rails_env, 'production'

task :setup_permissions do
  sudo "chown -R #{user}:#{user} #{deploy_to}"
end

before "peepcode:create_shared_config", "setup_permissions"


