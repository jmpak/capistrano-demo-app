set :application, "capistrano-demo-app.jmpak.com"
set :deploy_via, :remote_cache
set :user, "vagrant"
set :repository,  "https://github.com/jmpak/capistrano-demo-app.git"
set :normalize_asset_timestamps, false

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :deploy_to, "/var/www/apps/#{application}"
set :domain, application
role :web, domain                                          # Your HTTP server, Apache/etc
role :app, domain                          # This may be the same as your `Web` server
role :db,  domain, :primary => true # This is where Rails migrations will run

set :runner, user
set :rails_env, 'production'



