
require File.expand_path(File.dirname(__FILE__) + '/../base_drift_test')


class CircularActTest < BaseDriftTest



  setup do
    @context = BaseContext.new({'number' => 0, 'limit' => 10})
  end

  def test_act
    CircularAct.execute(@context)
    assert_equal 10, @context['number']
  end

end