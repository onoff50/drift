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

  def single_actor(activity, async = false, queue = nil)
    SingleActor.new(activity, generate_id, async, queue)
  end

  def switch_actor(condition, async = false, queue = nil)
    SwitchActor.new(condition, generate_id, async, queue)
  end

  private
  def generate_id
    UUIDTools::UUID.timestamp_create
  end
end