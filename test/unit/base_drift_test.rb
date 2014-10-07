require File.expand_path(File.dirname(__FILE__) + '/../test_config')

class SampleTestService
  class << self
    def sampleTestMethod(args)
      args['water'].blank?
    end
  end
end

class BaseDriftTest < ActiveSupport::TestCase
  include Drift
end