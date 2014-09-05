require 'active_model'
require 'rest_client'
require_relative 'pivotal-tracker-wrapper/version'

require File.join(File.dirname(__FILE__), 'pivotal-tracker-wrapper', 'client')
require File.join(File.dirname(__FILE__), 'pivotal-tracker-wrapper', 'project')
require File.join(File.dirname(__FILE__), 'pivotal-tracker-wrapper', 'story')

module PivotalTracker

  class ProjectNotSpecified < StandardError; end
  class NonParseableAnswer < StandardError; end

  def self.encode_options(options)
    #TODO: get parameters and build URL with filters
  end
end
