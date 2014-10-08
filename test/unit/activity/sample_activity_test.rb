require File.expand_path(File.dirname(__FILE__) + '/../base_drift_test')

class SampleActivityWithoutDoExecute < Drift:: BaseActivity

end

class SampleActivityWithDoExecute < Drift:: BaseActivity

  def self.do_execute(context)
    $logger.info 'Implementing Do Execute'
  end

end

class SampleActivityTest < BaseDriftTest

  setup do
    @sample_activity_without_execute = SampleActivityWithoutDoExecute
    @sample_activity_with_execute = SampleActivityWithDoExecute
    @sample_context = {:a => 'b'}
  end

  def test_do_execute_for_activity_without_execute
    assert_raise(DriftException, "Not Implemented") do
      @sample_activity_without_execute.perform(@sample_context)
    end
  end

  def test_do_execute_for_activity_with_execute
    assert_nothing_raised do
      @sample_activity_with_execute.perform(@sample_context)
    end
  end

end