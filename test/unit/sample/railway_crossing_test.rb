require File.expand_path(File.dirname(__FILE__) + '/../base_drift_test')

class RailwayCrossingTest < BaseDriftTest

  def test_one
    10.times do |i|
       puts "Attempt number #{i}"
       puts RailwayCrossing.print
       RailwayCrossing.execute(BaseContext.new({'start' => 'true'}))
     end
  end
end