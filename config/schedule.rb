# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

set :environment_variable, "APP_ENV"

job_type :command, ":task :output"
job_type :execute,    "cd :path && :environment_variable=:environment bundle exec :task :output"
job_type :rake,    "cd :path && :environment_variable=:environment bundle exec rake :task --silent :output"
job_type :runner,  "cd :path && :environment_variable=:environment ruby app.rb ':task' :output"
job_type :script,  "cd :path && :environment_variable=:environment bundle exec ruby :task :output"

every 1.day, :at => '2:33 am' do
  execute "thin restart -C config/thin_server.yml"
end

