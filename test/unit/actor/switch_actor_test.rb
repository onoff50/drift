require File.expand_path(File.dirname(__FILE__) + '/../base_drift_test')

class SwitchActorTest < BaseDriftTest
  include Drift

  setup do
    @switch_actor = switch_actor Proc.new {}

    add_water = single_actor AddWater
    add_noodles = single_actor AddNoodles
    add_spices = single_actor AddSpices
    cook_for_five_mins = single_actor CookForFiveMins

    @switch_actor.register_next add_water, 'alpha'
    @switch_actor.register_next add_noodles, 'beta'
    @switch_actor.register_next add_spices, 'gamma'
    @switch_actor.register_next cook_for_five_mins

    SampleAct.register_actors @switch_actor, add_water, add_noodles, add_spices, cook_for_five_mins
  end

  def test_switching_action_act_on_2_for_beta
    @switch_actor.condition = Proc.new {'beta'}
    a = @switch_actor.execute(BaseContext.new({}))

    assert_equal 'Added maggie noodles', a['noodles']
    assert_nil a['water']
    assert_nil a['spices']
  end

  def test_switching_action_act_on_4_for_other
    @switch_actor.condition = Proc.new {'other'}
    a = @switch_actor.execute(BaseContext.new({}))

    assert_equal 'Cook on gas for five minutes', a['cook']
    assert_nil a['spices']
    assert_nil a['water']
    assert_nil a['noodles']
  end

  def test_switching_action_act_on_4_for_default
    @switch_actor.condition = Proc.new {:default}
    a = @switch_actor.execute(BaseContext.new({}))

    assert_equal 'Cook on gas for five minutes', a['cook']
    assert_nil a['spices']
    assert_nil a['water']
    assert_nil a['noodles']
  end

end