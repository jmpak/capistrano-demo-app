set :application, "capistrano-demo-app.jmpak.com"
set :user, "vagrant"
set :repository,  "https://github.com/jmpak/capistrano-demo-app.git"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :deploy_to, "/var/www/apps/#{application}"
set :domain, application
role :web, domain                                          # Your HTTP server, Apache/etc
role :app, domain                          # This may be the same as your `Web` server
role :db,  domain, :primary => true # This is where Rails migrations will run

set :runner, user

set :mongrel_username, 3
set :mongrel_port, 8000
set :rails_env, 'production'

