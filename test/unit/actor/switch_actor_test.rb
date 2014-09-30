require File.expand_path(File.dirname(__FILE__) + '/../base_drift_test')

class SwitchActorTest < BaseDriftTest
  include Drift

  def test_switching_action_act_on_2_for_beta
    cond1 = Proc.new {'beta'}

    switch_actor = SwitchActor.new({'alpha' => AddWater, 'beta' => AddNoodles, 'gamma' => AddSpices, :default => CookForFiveMins}, cond1 )
    a = switch_actor.action(BaseContext.new({}))
    assert_equal 'Added maggie noodles', a['noodles']
    assert_nil a['water']
    assert_nil a['spices']
  end

  def test_switching_action_act_on_4_for_other
    cond1 = Proc.new {'other'}

    switch_actor = SwitchActor.new({'alpha' => AddWater, 'beta' => AddNoodles, 'gamma' => AddSpices, :default => CookForFiveMins}, cond1)
    a = switch_actor.action(BaseContext.new({}))
    assert_equal 'Cook on gas for five minutes', a['cook']
    assert_nil a['spices']
    assert_nil a['water']
    assert_nil a['noodles']
  end

  def test_switching_action_act_on_4_for_default
    cond1 = Proc.new {:default}
    switch_actor = SwitchActor.new({'alpha' => AddWater, 'beta' => AddNoodles, 'gamma' => AddSpices, :default => CookForFiveMins}, cond1 )
    a = switch_actor.action(BaseContext.new({}))
    assert_equal 'Cook on gas for five minutes', a['cook']
    assert_nil a['spices']
    assert_nil a['water']
    assert_nil a['noodles']
  end

end