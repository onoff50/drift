require File.expand_path(File.dirname(__FILE__) + '/../base_drift_test')

class SingleActorTest < BaseDriftTest
  include Drift

  def test_for_single_activity
    @condition_actor = SingleActor.new(SampleTestActivity1)
    assert_equal 'SAMPLE TEST ACTIVITY 1', @condition_actor.act(BaseContext.new({}))['act1']
  end

end