require File.expand_path(File.dirname(__FILE__) + '/../base_drift_test')

class RailwayCrossingTest < BaseDriftTest

  def test_all_action_called
    ctx = BaseContext.new({'start' => 'true', 'train_on_left' => true, })
    LookLeft.expects(:do_execute).with(ctx)

    RailwayCrossing.execute(ctx)

    assert_equal true, ctx['wait']
  end

  def test_one
    10.times do |i|
       puts "Attempt number #{i}"
       RailwayCrossing.execute(BaseContext.new({'start' => 'true'}))
     end
  end


  def test_load_dump



    ctx = BaseContext.new({'start' => 'true'} )

   nxt_actor_map =  RailwayCrossing.first_actor.next_actor_map

    orig_obj = {"args" => [ctx, nxt_actor_map]}
    puts "KKKK #{orig_obj.inspect}"
    json_dump = Sidekiq.dump_json(orig_obj)

    obj = Sidekiq.load_json(json_dump)

    puts "PPPP #{obj.inspect}"
  end

end