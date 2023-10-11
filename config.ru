require "dotenv"
require "redis"
require "roda"
require 'json'
require "./db.rb"
require "./app.rb"

run App.freeze.app
