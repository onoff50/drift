require File.expand_path(File.dirname(__FILE__) + '/../base_drift_test')

class TestActor < BaseActor

end
class BaseActorTest < BaseDriftTest

  #setup do
  #  @base_actor = TestActor.new
  #  @sample_context = {:a => 'b'}
  #end

  #def test_action
  #  TestActor.any_instance.expects(:do_action).with(@sample_context)
  #  r = @base_actor.action(@sample_context)
  #  assert_equal r, @sample_context
  #end
  #
  #def test_do_action
  #  assert_raise(DriftException, 'Not Implemented') do
  #    @base_actor.do_action(@sample_context)
  #  end
  #end
  #
  #def test_next_actor
  #  next_actor_obj = @base_actor.next_actor
  #  assert_equal nil, next_actor_obj
  #end
  #
  #def test_register_next
  #  next_actor_obj = @base_actor.register_next('Some Activity', 'Some Actor')
  #
  #  assert_equal nil, @base_actor.next_actor
  #  assert_equal "Some Actor", next_actor_obj
  #
  #  @base_actor.current_activity = 'Some Activity'
  #  assert_equal @base_actor.next_actor, 'Some Actor'
  #end

end