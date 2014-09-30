require File.expand_path(File.dirname(__FILE__) + '/../base_drift_test')

class SwitchActorTest < BaseDriftTest
  include Drift   

  def test_switching_action_act_on_2_for_beta
    switch_actor = SwitchActor.new({'alpha' => AddWater, 'beta' => AddNoodles, 'gamma' => AddSpices, :default => CookForFiveMins}) do
      'beta'
    end
    a = switch_actor.action(BaseContext.new({}))
    assert_equal 'Added maggie noodles', a['noodles']
    assert_nil a['water']
    assert_nil a['spices']
  end

  def test_switching_action_act_on_4_for_other
    switch_actor = SwitchActor.new({'alpha' => AddWater, 'beta' => AddNoodles, 'gamma' => AddSpices, :default => CookForFiveMins}) do
      'other'
    end
    a = switch_actor.action(BaseContext.new({}))
    assert_equal 'Cook on gas for five minutes', a['cook']
    assert_nil a['spices']
    assert_nil a['water']
    assert_nil a['noodles']
  end

  def test_switching_action_act_on_4_for_default
    switch_actor = SwitchActor.new({'alpha' => AddWater, 'beta' => AddNoodles, 'gamma' => AddSpices, :default => CookForFiveMins}) do
      :default
    end
    a = switch_actor.action(BaseContext.new({}))
    assert_equal 'Cook on gas for five minutes', a['cook']
  end

end