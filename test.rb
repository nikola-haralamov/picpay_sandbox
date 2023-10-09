#!/usr/bin/env ruby

require "bundler/setup"
require "picpay_sandbox"
require 'dotenv'
require 'time'

Dotenv.load('./.env.development')
