require File.expand_path(File.dirname(__FILE__) + '/../base_drift_test')


class BaseActTest < BaseDriftTest
  include Drift
  setup do
    f = BaseAct.single_actor(AddWater)

    BaseAct.first_actor = f

    f.register_next(BaseAct.single_actor(AddNoodles))
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