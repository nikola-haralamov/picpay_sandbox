require 'json'
require 'dotenv'
require 'redis'
require 'roda'
require './db.rb'
require './app.rb'

Dotenv.load('./.env')

run App.freeze.app
