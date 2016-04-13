# All environment variables must be set before you require sinatra
ENV['RACK_ENV'] = 'test'

require 'simplecov'     # Require Simple Cov to do code coverage.
SimpleCov.start do          # Start Simple Cov before we require any project code but after standard reburies.
  add_filter "/vendor/"
  add_filter "/spec/"
end

require 'rack/test'
require 'rspec'
require 'fileutils'
require 'pathname'
require 'json'
require 'yaml'
require 'pp'




RSpec.configure do |config|
  config.formatter = :progress
  config.color = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.mock_with :mocha
  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
end
