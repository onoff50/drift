require File.expand_path(File.dirname(__FILE__) + '/../base_drift_test')

class ConditionActorTest < BaseDriftTest
  include Drift

  def test_for_then_activity
    @condition_actor = ConditionActor.new(AddWater, AddNoodles) do
      SampleTestService.sampleTestMethod(true)
    end
    assert_equal 'Added 2 cups water to the recipe', @condition_actor.action(BaseContext.new({}))['water']
  end

  def test_for_else_activity
    @condition_actor = Drift::ConditionActor.new(AddWater, AddNoodles) do
      SampleTestService.sampleTestMethod(false)
    end
    assert_equal 'Added maggie noodles', @condition_actor.action(BaseContext.new({}))['noodles']
  end

  def test_for_null_else_activity
    @condition_actor = Drift::ConditionActor.new(AddWater, nil) do
      SampleTestService.sampleTestMethod(false)
    end
    assert_equal nil, @condition_actor.action({})
  end

end