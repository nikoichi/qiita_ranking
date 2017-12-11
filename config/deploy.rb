# config valid for current version and patch releases of Capistrano
lock "~> 3.10.1"

set :application, "qiita_ranking"
set :repo_url, "git@github.com:nikoichi/qiita_ranking.git"

# デプロイ先のサーバで、ユーザディレクトリでrbenvをインストールしている場合
set :rbenv_type, :user
set :rbenv_ruby, '2.4.1'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/var/www/qiita_ranking"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, "config/database.yml", "config/secrets.yml"

# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", 'vendor/bundle', 'public/assets'

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
set :keep_releases, 3

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

# ridgepole
set :ridgepole_schema_file, File.join(current_path, '', 'Schemafile')
after 'deploy:publishing', 'ridgepole:apply'

after 'deploy:publishing', 'deploy:restart'

namespace :deploy do
  desc 'reload the database with seed data'
  task :seed do
    on primary fetch(:migration_role) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'db:seed'
        end
      end
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'unicorn:restart'
    end
  end
end

