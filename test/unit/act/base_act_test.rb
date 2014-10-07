require File.expand_path(File.dirname(__FILE__) + '/../base_drift_test')


class BaseActTest < BaseDriftTest
  include Drift
  setup do
    f = BaseAct.single_actor(AddWater)

    BaseAct.first_actor = f

    f.register_next(BaseAct.single_actor(AddNoodles) )
  end

  def test_single_run
    args = {}
    BaseAct.execute(BaseContext.new(args))
    assert_equal 'Added 2 cups water to the recipe', args['water']
    assert_equal 'Added maggie noodles', args['noodles']
  end
end