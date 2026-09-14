lock "~> 3.20.1"

set :application, "task_app"
set :repo_url, "https://github.com/arduino0420/task_app.git"
set :linked_files, %w{config/master.key}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets public/uploads}
set :keep_releases, 5
set :rbenv_ruby, "4.0.6"
set :log_level, :info
set :branch, "main"
set :linked_files, %w{config/master.key .env}

set :default_env, {
  "TASK_APP_DATABASE_PASSWORD" => ENV["TASK_APP_DATABASE_PASSWORD"]
}

set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock"
set :puma_access_log, "#{shared_path}/log/puma_access.log"
set :puma_error_log, "#{shared_path}/log/puma_error.log"

after "deploy:published", "deploy:seed"
after "deploy:finished", "deploy:restart"

namespace :deploy do
  desc "Run seed"
  task :seed do
    on roles(:db) do
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, "db:seed"
        end
      end
    end
  end

  desc "Restart application"
  task :restart do
    invoke "puma:restart"
  end
end