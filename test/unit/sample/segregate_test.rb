
require File.expand_path(File.dirname(__FILE__) + '/../base_drift_test')

class SegregateTest < BaseDriftTest

  def test_all_actors_called
    FetchData.expects(:perform)
    WriteAuditLogs.expects(:perform)
    Segregate.execute(BaseContext.new({}))
  end

  def test_one
    a = {}
    cxt = BaseContext.new(a)
    a['abc'] = 'def'
    Segregate.execute(cxt)
    assert_true(cxt['audited'])
    assert_true(cxt['category_id'].present?)
    assert_true(cxt['wsn'].present?)
    puts cxt
  end

end