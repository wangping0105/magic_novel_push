# config valid only for Capistrano 3.4.0
lock '>=3.6.0'

set :application, 'magic_novel_push'
set :repo_url, 'git@github.com:wangping0105/magic_novel_push.git'

# deploy.rb or stage file (staging.rb, production.rb or else)
set :rvm_type, :auto                     # Defaults to: :auto
# set :rvm_ruby_version, '2.1.1-p76'      # Defaults to: 'default'
# set :rvm_ruby_version, '2.3.0'
# set :rvm_custom_path, '~/.myveryownrvm'  # only needed if not detected


# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
# set :deploy_to, '/var/www/my_app'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}
set :linked_files, %W{config/app.god config/cross_sites.yml config/nginx.conf config/thin_server.yml config/redis.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }

namespace :deploy do

  desc 'start ikcrm_push server'
  task :start do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
      within release_path do
        execute :bundle, 'exec thin start -C config/thin_server.yml -R config.ru'
      end
    end
  end

  desc 'stop ikcrm_push server'
  task :stop do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
      within release_path do
        execute :bundle, 'exec thin stop -C config/thin_server.yml -R config.ru'
      end
    end
  end

  desc 'restart ikcrm_push server'
  task :restart do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
      within release_path do
        execute :bundle, 'exec thin restart -C config/thin_server.yml -R config.ru'
      end
    end
  end
  after :publishing, :restart

  desc 'upload setup_config for application'
  task :upload_config do
    on roles(:web), in: :sequence, wait: 5 do
      invoke "deploy:check:make_linked_dirs"

      fetch(:linked_files).each do |file_path|
        unless test "[ -f #{shared_path}/#{file_path} ]"
          upload!("#{file_path}", "#{shared_path}/#{file_path}", via: :scp)
        end
      end
    end
  end

  desc 'update git remote repo url'
  task :update_git_repo do
    on release_roles :all do
      with fetch(:git_environmental_variables) do
        within repo_path do
          current_repo_url = execute :git, :config, :'--get', :'remote.origin.url'
          unless repo_url == current_repo_url
            execute :git, :remote, :'set-url', 'origin', repo_url
            execute :git, :remote, :update

            execute :git, :config, :'--get', :'remote.origin.url'
          end
        end
      end
    end
  end
end
