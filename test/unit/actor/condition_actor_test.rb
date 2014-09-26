require File.expand_path(File.dirname(__FILE__) + '/../base_drift_test')

class SampleThenActivity < Drift::BaseActivity
  class << self
    def execute(args = {})
      return 'Then executed'
    end
  end
end

class SampleElseActivity < Drift::BaseActivity
  class << self
    def execute(args = {})
      return 'Else executed'
    end
  end
end

class SampleTestService
  class << self
    def sampleTestMethod(return_value)
      return return_value
    end
  end
end

class ConditionActorTest < BaseDriftTest

  def test_for_then_activity
    @condition_actor = Drift::ConditionActor.new(SampleThenActivity, SampleElseActivity) do
      SampleTestService.sampleTestMethod(true)
    end
    assert_equal 'Then executed', @condition_actor.act({})
  end

  def test_for_else_activity
    @condition_actor = Drift::ConditionActor.new(SampleThenActivity, SampleElseActivity) do
      SampleTestService.sampleTestMethod(false)
    end
    assert_equal 'Else executed', @condition_actor.act({})
  end

  def test_for_null_else_activity
    @condition_actor = Drift::ConditionActor.new(SampleThenActivity, nil) do
      SampleTestService.sampleTestMethod(false)
    end
    assert_equal nil, @condition_actor.act({})
  end


end