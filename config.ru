require 'securerandom'
require 'json'
require 'dotenv'
require 'redis'
require 'roda'
require './app/db.rb'

Dotenv.load('./.env')

Dir.glob('./app/controllers/*.rb', base: __dir__).each do |filepath|
  require_relative filepath
  unless File.basename(filepath, ".*") == 'base'
    run eval(File.basename(filepath, ".*").capitalize).freeze.app
  end
end
