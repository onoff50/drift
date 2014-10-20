require File.expand_path(File.dirname(__FILE__) + '/../base_drift_test')

class BaseActTest < BaseDriftTest
  include Drift
  setup do
    a1 = single_actor(AddWater, BaseAct.name, 10)
    a2 = single_actor(AddNoodles, BaseAct.name, 20)
    a1.register_next_actor(a2)

    BaseAct.start = a1
    BaseAct.register_actors a1, a2
  end

  def test_single_run
    args = {}
    ctx = BaseContext.new(args)
    BaseAct.execute(ctx)
    assert_equal 'Added 2 cups water to the recipe', ctx['water']
    assert_equal 'Added maggie noodles', ctx['noodles']

    assert_nil args['water']
    assert_nil args['noodles']
  end

  def test_execute_next

  end

  def test_register_actors

  end

end