#source 'https://rubygems.org'
source 'https://gems.ruby-china.org'

# pub/sub system Stack
# Simple pub/sub messaging for the web
gem 'faye', '~> 1.2', '>= 1.2.2'
gem 'faye-redis', '~> 0.2.0'
gem 'thin', '~> 1.7'

gem 'whenever', :require => false

########  framework  base support ########
gem "bunny"
gem 'activesupport', '~> 5.0'

# gem 'mysql2', '~> 0.3.18'
# gem "activerecord"

gem 'httparty', '~> 0.14.0'
# gem "daemons"

######## deployment ########

# gem 'god'

group :production do
  gem 'newrelic_rpm', '~> 3.16', '>= 3.16.0.318'
end

group :development do
  gem 'capistrano', '~> 3.6'
  gem 'capistrano-rvm'
  gem 'capistrano-bundler'
end
group :development do
  gem "rake"
  gem 'pry'
  gem 'pry-remote'
  gem 'pry-nav'
end
