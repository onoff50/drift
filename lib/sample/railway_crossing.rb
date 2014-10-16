include DriftHelper
include Drift

class LookLeft < BaseActivity
  def self.do_execute(context)
    Random.rand(10) / 2 == 1 ? context['train_on_left']= true : context['train_on_left']= false
  end
end

class LookRight < BaseActivity
  def self.do_execute(context)
    Random.rand(10) / 2 == 1 ? context['train_on_right']= true : context['train_on_right']= false
  end
end

class CrossNow < BaseActivity
  def self.do_execute(context)
    context['crossed']= true
    context['message']= 'Hurrey !!'
  end
end

class WaitForTrain < BaseActivity
  def self.do_execute(context)
    $logger.info 'Waiting for 5 minutes...'
    context['wait']= true
    context['message']= 'Retry after 5 minutes !!'
  end
end


class RailwayCrossing < BaseAct

  condition1 = Proc.new do |ctx|
    ctx['train_on_left']
  end

  condition2 = Proc.new do |ctx|
    ctx['wait']
  end

  condition3 = Proc.new do |ctx|
    ctx['train_on_right']
  end

  a1 = single_actor(LookLeft, self.name, 'look_left')
  a2 = condition_actor(WaitForTrain, LookRight, condition1, self.name, 10, true)
  a3 = condition_actor(LookRight, nil, condition2, self.name, 2)
  a4 = condition_actor(WaitForTrain, CrossNow, condition3, self.name, 3)

  RailwayCrossing.start = a1
  RailwayCrossing.register_actors a1, a2, a3, a4

  a1.register_next_actor(a2)
  a2.register_next_actor(a3, 'WaitForTrain')
  a2.register_next_actor(a4, 'LookRight')

end

