# encoding: utf-8

require 'rubygems'
require 'bundler/setup'

if defined?(Bundler)
  Bundler.require
end

# require 'active_record'
# require 'active_model'

require 'active_support/all'

require "bunny"
require "logger"
require "yaml"
require "open-uri"
require "httparty"
