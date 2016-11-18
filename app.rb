# encoding: utf-8
$:.push File.dirname(__FILE__)

require 'boot'

APP_ROOT = File.dirname(__FILE__)
APP_ROOT_PATH = Pathname.new(APP_ROOT)

ENV["APP_ENV"] ||= (ENV["RACK_ENV"] || "development")

case ENV["APP_ENV"].to_sym
when :development
  require "#{APP_ROOT}/config/environments/development"
when :test
  require "#{APP_ROOT}/config/environments/test"
when :production
  require "#{APP_ROOT}/config/environments/production"
end

if File.exists?("#{APP_ROOT}/config/newrelic.yml")
  require 'newrelic_rpm'
end

APP_ENV = ENV["APP_ENV"]

if File.exists?("#{APP_ROOT}/config/database.yml")
  DATABASE_CONFIG = HashWithIndifferentAccess.new(YAML.load_file("#{APP_ROOT}/config/database.yml")[APP_ENV] || {})
end

if File.exists?("#{APP_ROOT}/config/redis.yml")
  REDIS_CONFIG = HashWithIndifferentAccess.new(YAML.load_file("#{APP_ROOT}/config/redis.yml")[APP_ENV] || {})
end

CROSS_SITE_CONFIG = HashWithIndifferentAccess.new(YAML.load_file("#{APP_ROOT}/config/cross_sites.yml")[APP_ENV] || {})

$logger = ActiveSupport::Logger.new("#{APP_ROOT}/log/#{APP_ENV}.log", "weekly")

Dir.glob(APP_ROOT + "/config/initializers/*.rb").each {|f| require f}

relative_load_paths = Dir[
  "#{APP_ROOT}/app/models/*",
  # "#{APP_ROOT}/app/models/**/",
  "#{APP_ROOT}/app/models/concenrs/"
]
# ActiveSupport::Dependencies.autoload_paths += relative_load_paths

# Dir.glob(APP_ROOT + "/lib/*.rb").each {|f| require f}
require "lib/lib_core"
