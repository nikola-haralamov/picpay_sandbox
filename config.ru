require 'securerandom'
require 'json'
require 'dotenv'
require 'redis'
require 'roda'
require 'oauth2'
require 'jwt'

Dotenv.load('./.env')

Dir.glob('./app/routes/*.rb', base: __dir__) { |f| require_relative f }
Dir.glob('./app/*.rb', base: __dir__) { |f| require_relative f }

run App.freeze.app
