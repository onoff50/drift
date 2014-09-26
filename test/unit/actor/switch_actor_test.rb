require File.expand_path(File.dirname(__FILE__) + '/../base_drift_test')

class SampleTestActivity1 < Drift::BaseActivity
  def self.execute(args = {})
    "SAMPLE TEST ACTIVITY 1"
  end
end

class SampleTestActivity2 < Drift::BaseActivity
  def self.execute(args = {})
    "SAMPLE TEST ACTIVITY 2"
  end
end

class SampleTestActivity3 < Drift::BaseActivity
  def self.execute(args = {})
    "SAMPLE TEST ACTIVITY 3"
  end
end

class SampleTestActivity4 < Drift::BaseActivity
  def self.execute(args = {})
    "SAMPLE TEST ACTIVITY 4"
  end
end

class SwitchActorTest < BaseDriftTest

  setup do
    @activity1 = SampleTestActivity1.new
    @activity2 = SampleTestActivity2.new
    @activity3 = SampleTestActivity3.new
    @defaultActivity = SampleTestActivity4.new
  end

  def test_switching_action_act_on_2_for_beta
    switchActor = Drift::SwitchActor.new({'alpha' => SampleTestActivity1, 'beta' => SampleTestActivity2, 'gamma' => SampleTestActivity3, :default => SampleTestActivity4}) do
      'beta'
    end
    a = switchActor.act({})
    assert_equal 'SAMPLE TEST ACTIVITY 2', a
  end

  def test_switching_action_act_on_4_for_other
    switchActor = Drift::SwitchActor.new({'alpha' => SampleTestActivity1, 'beta' => SampleTestActivity2, 'gamma' => SampleTestActivity3, :default => SampleTestActivity4}) do
      'other'
    end
    a = switchActor.act({})
    assert_equal 'SAMPLE TEST ACTIVITY 4', a
  end

  def test_switching_action_act_on_4_for_default
   switchActor = Drift::SwitchActor.new({'alpha' => SampleTestActivity1, 'beta' => SampleTestActivity2, 'gamma' => SampleTestActivity3, :default => SampleTestActivity4}) do
      :default
    end
    a = switchActor.act({})
    assert_equal 'SAMPLE TEST ACTIVITY 4', a
  end

end