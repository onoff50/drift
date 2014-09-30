require File.expand_path(File.dirname(__FILE__) + '/../base_drift_test')


class BaseActTest < BaseDriftTest
  include Drift
  setup do
    BaseAct.register_actors({
                                     1 => SingleActor.new(AddWater),
                                     2 => SingleActor.new(AddNoodles)

                                 })
  end

  def test_single_run
    args = {}
    BaseAct.execute(BaseContext.new(args))
    assert_equal 'Added 2 cups water to the recipe', args['water']
    assert_equal 'Added maggie noodles', args['noodles']
  end
end