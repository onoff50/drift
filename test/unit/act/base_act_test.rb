require File.expand_path(File.dirname(__FILE__) + '/../base_drift_test')



class BaseActTest < BaseDriftTest
  include Drift
  setup do
    f = single_actor(AddWater, BaseAct, 10)
    BaseAct.start = f
    a1 = single_actor(AddNoodles, BaseAct, 20)
    f.register_next_actor(a1)

    BaseAct.register_actor(f)
    BaseAct.register_actor(a1)
  end

  def test_single_run
    args = {}
    ctx =BaseContext.new(args)
    BaseAct.execute(ctx)
    assert_equal 'Added 2 cups water to the recipe', ctx['water']
    assert_equal 'Added maggie noodles', ctx['noodles']

    assert_nil args['water']
    assert_nil args['noodles']
  end
end