require File.expand_path(File.dirname(__FILE__) + '/../base_drift_test')

class SingleActorTest < BaseDriftTest
  include Drift

  def test_for_single_activity
    @condition_actor = SingleActor.new(AddWater, SampleAct.name, 20, false)
    assert_equal 'Added 2 cups water to the recipe', @condition_actor.execute(BaseContext.new({}))['water']
  end

  def test_do_action

  end

  def test_create_metadata

  end


  def test_rollback_actor

  end

end