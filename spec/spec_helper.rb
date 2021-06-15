require 'simplecov'
require 'simplecov-rcov'
SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter
SimpleCov.start do
  add_group 'Eol', 'lib/eol'
  add_group 'Faraday Middleware', 'lib/faraday'
  add_group 'Specs', 'spec'
end

require File.expand_path('../../lib/eol', __FILE__)

require 'rspec'
require 'webmock/rspec'
RSpec.configure do |config|
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
  config.include WebMock::API
  config.before(:each) do
    Eol.reset
  end
end
