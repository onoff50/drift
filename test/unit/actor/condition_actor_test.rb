require File.expand_path(File.dirname(__FILE__) + '/../base_drift_test')

class ConditionActorTest < BaseDriftTest
  include Drift

  setup do
    @condition = Proc.new do |args|
      SampleTestService.sampleTestMethod(args)
    end
  end

  def test_for_then_activity
    condition_actor = ConditionActor.new(AddWater, AddNoodles, @condition)
    context = condition_actor.action(BaseContext.new({}))
    assert_equal context['water'], 'Added 2 cups water to the recipe'
  end

  def test_for_else_activity
    condition_actor = Drift::ConditionActor.new(AddWater, AddNoodles, @condition)
    context = condition_actor.action(BaseContext.new({'water' => 'already present'}))
    assert_equal context['noodles'], 'Added maggie noodles'
  end

  def test_for_null_else_activity
    condition_actor = Drift::ConditionActor.new(AddWater, nil, @condition)
    context = condition_actor.action(BaseContext.new({'water' => 'already present'}))
    #did not execute the if part
    assert_equal context['water'], 'already present'
    assert_equal context.size, 1
  end

  def test_condition_false_else_not_specified

  end

  def test_next_actor_for_then
    condition_actor = Drift::ConditionActor.new(AddWater, AddNoodles, @condition)
    context = condition_actor.action(BaseContext.new({}))
    condition_actor.register_next(AddWater, 'THEN_ACTOR')
    condition_actor.register_next(AddNoodles, 'ELSE_ACTOR')
    assert_equal context['water'], 'Added 2 cups water to the recipe'
    assert_equal 'THEN_ACTOR', condition_actor.next_actor
  end

  def test_next_actor_for_else
    condition_actor = Drift::ConditionActor.new(AddWater, AddNoodles, @condition)
    context = condition_actor.action(BaseContext.new({'water' => 'already present'}))
    condition_actor.register_next(AddWater, 'THEN_ACTOR')
    condition_actor.register_next(AddNoodles, 'ELSE_ACTOR')
    assert_equal context['noodles'], 'Added maggie noodles'
    assert_equal 'ELSE_ACTOR', condition_actor.next_actor
  end
end