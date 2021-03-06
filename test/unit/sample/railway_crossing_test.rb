require File.expand_path(File.dirname(__FILE__) + '/../base_drift_test')
Drift::Testing.inline!

class RailwayCrossingTest < BaseDriftTest

  def test_all_action_called
    ctx = BaseContext.new({'start' => 'true', 'train_on_left' => true, })
    LookLeft.expects(:do_execute).with(ctx)

    RailwayCrossing.execute(ctx)
  end

  def test_one
    10.times do |i|
      $logger.info "Attempt number #{i}"
      RailwayCrossing.execute(BaseContext.new({'start' => 'true'}))
    end
  end
end