require File.expand_path(File.dirname(__FILE__) + '/../base_drift_test')

class SampleTestActivity < Drift::BaseActivity

  def execute
    puts 'successfully executed'
  end

end

class SampleTestService
  class << self

    def sampleTestMethodReturnsTrue
      return 3 > 2
    end

  end
end

class ConditionActorTest < BaseDriftTest

  setup do
    @activity_1 = SampleTestActivity.new
    @activity_2 = SampleTestActivity.new
  end

  def test_with_null_then_activity
    @condition_actor = Drift::ConditionActor.new @activity_1, @activity_2 do
      SampleTestService.sampleTestMethodReturnsTrue
    end

    @condition_actor.act
  end


end