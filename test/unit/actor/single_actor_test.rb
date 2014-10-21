require File.expand_path(File.dirname(__FILE__) + '/../base_drift_test')

class SingleActorTest < BaseDriftTest
  include Drift

  def test_for_single_activity
    @single_actor = single_actor AddWater
    assert_equal 'Added 2 cups water to the recipe', @single_actor.execute(BaseContext.new({}))['water']
  end

  def test_next_actor

  end

end