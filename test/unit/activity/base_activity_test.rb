require File.expand_path(File.dirname(__FILE__) + '/../base_drift_test')

class BaseActivityTest < BaseDriftTest

  setup do
      @base_activity = BaseActivity
    puts @base_activity.name
  end

  def test_sample
    puts "hello world !!!"
  end

  def test_exception_for_not_implemented
    assert_raise(DriftException) do
        MyActivity.execute({})
    end
  end

end