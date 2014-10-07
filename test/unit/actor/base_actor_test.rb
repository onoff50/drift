require File.expand_path(File.dirname(__FILE__) + '/../base_drift_test')

class BaseActorTest < BaseDriftTest

  setup do
    @base_actor = BaseActor.new
    @sample_context = {:a => 'b'}
  end

  def test_action
    assert_raise(DriftException, 'Not Implemented') do
      @base_actor.action(@sample_context)
    end
  end

  def test_do_action
    assert_raise(DriftException, 'Not Implemented') do
      @base_actor.do_action(@sample_context)
    end
  end

  def test_next_actor
    next_actor_obj = @base_actor.next_actor
    assert_equal(nil, next_actor_obj)
  end

  def test_register_next
    next_actor_obj = @base_actor.register_next("Some Activity", "Some Actor")
    assert_equal("Some Actor", next_actor_obj)
    assert_equal(@base_actor.next_actor_map, {"Some Activity" => "Some Actor"})
  end

end