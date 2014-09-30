require File.expand_path(File.dirname(__FILE__) + '/../base_drift_test')

class SingleActorTest < BaseDriftTest
  include Drift

  def test_for_single_activity
    @condition_actor = SingleActor.new(AddWater)
    assert_equal 'Added 2 cups water to the recipe', @condition_actor.action(BaseContext.new({}))['water']
  end

end