require File.expand_path(File.dirname(__FILE__) + '/../base_drift_test')

class BaseActivityTest < BaseDriftTest

  setup do
      @base_activity = Drift::BaseActivity.new "create_courier_return", "creates DB model"
    puts @base_activity.name
  end

  def test_sample
    puts "hello world !!!"
  end
end