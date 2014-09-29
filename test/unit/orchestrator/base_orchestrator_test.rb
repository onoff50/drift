require File.expand_path(File.dirname(__FILE__) + '/../base_drift_test')


class BaseOrchestratorTest < BaseDriftTest
  include Drift
  setup do
    BaseWorkflow.register_actors({
                                     1 => SingleActor.new(SampleTestActivity1),
                                     2 => SingleActor.new(SampleTestActivity2)

                                 })
  end

  def test_single_run
    args = {}
    BaseWorkflow.execute(BaseContext.new(args))
    assert_equal 'SAMPLE TEST ACTIVITY 1', args['act1']
    assert_equal 'SAMPLE TEST ACTIVITY 2', args['act2']
  end
end