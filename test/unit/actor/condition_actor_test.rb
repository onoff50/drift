require File.expand_path(File.dirname(__FILE__) + '/../base_drift_test')

class ConditionActorTest < BaseDriftTest
  include Drift

  def test_for_then_activity
    @condition_actor = ConditionActor.new(SampleTestActivity1, SampleTestActivity2) do
      SampleTestService.sampleTestMethod(true)
    end
    assert_equal 'SAMPLE TEST ACTIVITY 1', @condition_actor.act(BaseContext.new({}))['act1']
  end

  def test_for_else_activity
    @condition_actor = Drift::ConditionActor.new(SampleTestActivity1, SampleTestActivity2) do
      SampleTestService.sampleTestMethod(false)
    end
    assert_equal 'SAMPLE TEST ACTIVITY 2', @condition_actor.act(BaseContext.new({}))['act2']
  end

  def test_for_null_else_activity
    @condition_actor = Drift::ConditionActor.new(SampleTestActivity1, nil) do
      SampleTestService.sampleTestMethod(false)
    end
    assert_equal nil, @condition_actor.act({})
  end

end