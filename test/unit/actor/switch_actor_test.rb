require File.expand_path(File.dirname(__FILE__) + '/../base_drift_test')

class SampleTestActivity1 < Drift::BaseActivity
    def execute(args = {})
      "SAMPLE TEST ACTIVITY 1"
    end
end

class SampleTestActivity2  < Drift::BaseActivity
    def execute(args = {})
      "SAMPLE TEST ACTIVITY 2"
    end
end

class SampleTestActivity3 < Drift::BaseActivity
    def execute(args = {})
      "SAMPLE TEST ACTIVITY 3"
    end
end

class SampleTestActivity4 < Drift::BaseActivity
    def execute(args = {})
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

  def test_switching_action
    switchActor = Drift::SwitchActor.new({'alpha' => @activity1, 'beta' => @activity2, 'gamma' => @activity3, :default => @defaultActivity}) do
      'beta'
    end
    a = switchActor.act({})
    assert_equal 'SAMPLE TEST ACTIVITY 2', a

    switchActor = Drift::SwitchActor.new({'alpha' => @activity1, 'beta' => @activity2, 'gamma' => @activity3, :default => @defaultActivity}) do
      'other'
    end
    a = switchActor.act({})
    assert_equal 'SAMPLE TEST ACTIVITY 4', a

    switchActor = Drift::SwitchActor.new({'alpha' => @activity1, 'beta' => @activity2, 'gamma' => @activity3, :default => @defaultActivity}) do
      'default'
    end
    a = switchActor.act({})
    assert_equal 'SAMPLE TEST ACTIVITY 4', a

  end
end