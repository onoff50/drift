require File.expand_path(File.dirname(__FILE__) + '/../test_config')

class SampleTestService
  class << self
    def sampleTestMethod(args)
      args['water'].nil?
    end
  end
end

class SampleAct < BaseAct
  @act_metadata = ActMetadata.new
end

class BaseDriftTest < ActiveSupport::TestCase
  include Drift
end