include Drift

class LookLeft < BaseActivity
  def self.do_execute(context)
    Random.rand(10) / 2 == 1 ? context.add('train_on_left', true) : context.add('train_on_left', false)
  end
end

class LookRight < BaseActivity
  def self.do_execute(context)
    Random.rand(10) / 2 == 1 ? context.add('train_on_right', true) : context.add('train_on_right', false)
  end
end

class CrossNow < BaseActivity
  def self.do_execute(context)
    context.add('crossed', true)
    context.add!('message', 'Hurrey !!')
  end
end

class WaitForTrain < BaseActivity
  def self.do_execute(context)
    $logger.info 'Waiting for 5 minutes...'
    context.add!('wait', true)
    context.add!('message', 'Retry after 5 minutes !!')
  end
end


class RailwayCrossing < BaseAct

  @first_actor = single_actor(LookLeft)

  condition1 = Proc.new do |ctx|
    ctx['train_on_left']
  end

  condition2 = Proc.new do |ctx|
    ctx['wait']
  end

  condition3 = Proc.new do |ctx|
    ctx['train_on_right']
  end

  c1 = condition_actor(WaitForTrain, LookRight, condition1)
  c2 = condition_actor(LookRight, nil, condition2)
  c3 = condition_actor(WaitForTrain, CrossNow, condition3)

  @first_actor.register_next(c1)
  c1.register_next(WaitForTrain,c2 )
  c1.register_next(LookRight, c3)
  c2.register_next(LookRight, c3)

end

