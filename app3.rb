#app3.rb

EVN['RACK_ENV'] ||= 'development'

require 'bundler'
Bundler.require :default, ENV['RACK_ENV'].to_sym

require_relative 'helpers'
require_relative 'routes/secrets'
require_relative 'routes/sessions'

class SimpleApp < Sinatra::Base
  #No changes here - left out for brevity
end
