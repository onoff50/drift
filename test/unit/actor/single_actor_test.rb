require File.expand_path(File.dirname(__FILE__) + '/../base_drift_test')

class RaiseExceptionActivity < Drift::BaseActivity
  def self.do_execute(context)
    $logger.info 'Raising exception'
    raise DriftException, 'Do not simply call me'
  end
end

class RollbackActivity < Drift::BaseActivity
  def self.do_execute(context)
    $logger.info 'Rolling back'
    context['rollback']= 'Done!'
  end
end

class RaiseExceptionAct < BaseAct
  a1 = single_actor RaiseExceptionActivity
  a2 = single_actor RollbackActivity
  a3 = single_actor AddWater

  a1.register_rollback a2
  a1.register_next a3

  RaiseExceptionAct.start = a1
  RaiseExceptionAct.register_actors a1, a2, a3
end

class SingleActorTest < BaseDriftTest
  include Drift

  def test_for_single_activity
    @single_actor = single_actor AddWater
    assert_equal 'Added 2 cups water to the recipe', @single_actor.execute(BaseContext.new({}))['water']
  end

  def test_next_actor

  end

  def test_rollback_actor
    assert_raise do
      RaiseExceptionAct.execute(BaseContext.new({}))
    end
  end

end