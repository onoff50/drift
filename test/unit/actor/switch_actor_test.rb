require File.expand_path(File.dirname(__FILE__) + '/../base_drift_test')

class SwitchActorTest < BaseDriftTest
  include Drift

  def test_switching_action_act_on_2_for_beta
    switchActor = SwitchActor.new({'alpha' => SampleTestActivity1, 'beta' => SampleTestActivity2, 'gamma' => SampleTestActivity3, :default => SampleTestActivity4}) do
      'beta'
    end
    a = switchActor.act(BaseContext.new({}))
    assert_equal 'SAMPLE TEST ACTIVITY 2', a['act2']
  end

  def test_switching_action_act_on_4_for_other
    switchActor = SwitchActor.new({'alpha' => SampleTestActivity1, 'beta' => SampleTestActivity2, 'gamma' => SampleTestActivity3, :default => SampleTestActivity4}) do
      'other'
    end
    a = switchActor.act(BaseContext.new({}))
    assert_equal 'SAMPLE TEST ACTIVITY 4', a['act4']
  end

  def test_switching_action_act_on_4_for_default
    switchActor = SwitchActor.new({'alpha' => SampleTestActivity1, 'beta' => SampleTestActivity2, 'gamma' => SampleTestActivity3, :default => SampleTestActivity4}) do
      :default
    end
    a = switchActor.act(BaseContext.new({}))
    assert_equal 'SAMPLE TEST ACTIVITY 4', a['act4']
  end

end