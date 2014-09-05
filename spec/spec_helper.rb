
Bundler.require(:default, :runtime, :test)
require "webmock/rspec"
require_relative '../lib/pivotal-tracker-wrapper'


USERNAME=ENV['PIVOTAL_USERNAME']
PASSWORD=ENV['PIVOTAL_PASSWORD']
NAME=ENV['PIVOTAL_NAME']
PROJECT_ID=ENV['PIVOTAL_PROJECT_ID']

RSpec.configure do |config|
  # Allow focus on a specific test if specified
  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true

  config.before :each do
    PivotalTracker::Client.clear_connections
  end
end

VCR.configure do |c|
  c.cassette_library_dir = './spec/fixtures/vcr'
  c.hook_into :webmock
end
