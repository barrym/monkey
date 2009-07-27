set :application, "monkey"
set :domain, "theshining.org"
set :applicationdir, "/var/www/railsapps/monkey"

set :scm, :git
set :repository,  "git://github.com/barrym/monkey.git"

set :rails_env, "production"

role :app, domain
role :web, domain
role :db,  domain, :primary => true

set :deploy_to, applicationdir
set :deploy_via, :remote_cache

set :use_sudo, false

namespace :deploy do

  desc "Restarts Passenger"
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end

end

desc "create a shared/resources directory for common, non-svn files (like database.yml)"
task :after_setup, :roles => [:app, :db, :web] do
  run <<-CMD
  mkdir -p -m 777 #{shared_path}/resources &&
  touch #{shared_path}/resources/database.yml
  chmod 600 #{shared_path}/resources/database.yml
  CMD
  run <<-CMD
  mkdir -p -m 777 #{shared_path}/public/pictures
  CMD
end

desc "create a symlink for the database.yml file for the current project (since it isn't in source control)"
task :after_update_code, :roles => [:app, :db, :web] do
  run <<-CMD
  ln -nfs #{shared_path}/resources/database.yml
  #{release_path}/config/database.yml
  CMD
  run <<-CMD
  ln -nfs #{shared_path}/public/pictures
  #{release_path}/public/pictures
  CMD
end
