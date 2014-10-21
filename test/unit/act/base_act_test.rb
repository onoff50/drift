require File.expand_path(File.dirname(__FILE__) + '/../base_drift_test')

class BaseActTest < BaseDriftTest
  include Drift
  setup do
    a1 = single_actor AddWater
    a2 = single_actor AddNoodles
    a1.register_next a2

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
end