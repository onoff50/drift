require File.expand_path(File.dirname(__FILE__) + '/../base_drift_test')

class BaseActivityTest < BaseDriftTest
  Sidekiq::Testing.fake!

  setup do
    @base_activity = BaseActivity
    @sample_context = {:a => 'b'}
  end

  def test_perform
    BaseActivity.expects(:pre_activity).with(@sample_context)
    BaseActivity.expects(:do_execute).with(@sample_context)
    BaseActivity.expects(:post_activity).with(@sample_context)
    @base_activity.perform(@sample_context)
  end

  #def test_perform_async
  #  assert_equal 0, BaseActivity.jobs.size
  #  @base_activity.perform_async(@sample_context)
  #  assert_equal 1, BaseActivity.jobs.size
  #  assert_raise(DriftException, "Not Implemented") do
  #    BaseActivity.drain
  #  end
  #  assert_equal 0, BaseActivity.jobs.size
  #end

  def test_do_execute
    assert_raise(DriftException, "Not Implemented") do
      @base_activity.do_execute(@sample_context)
    end
  end

  def test_pre_execute
     #todo nothing to implement
  end

  def test_post_execute
    #todo nothing to implement
  end

end