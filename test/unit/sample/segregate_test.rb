
require File.expand_path(File.dirname(__FILE__) + '/../base_drift_test')

class SegregateTest < BaseDriftTest

  def test_all_actors_called
    FetchData.expects(:execute)
    WriteAuditLogs.expects(:execute)
    Segregate.execute(BaseContext.new({}))
  end

  def test_one
    cxt = BaseContext.new(a)
    Segregate.execute(cxt)
    assert_true(cxt['audited'])
    assert_true(cxt['category_id'].present?)
    assert_true(cxt['wsn'].present?)
  end

end