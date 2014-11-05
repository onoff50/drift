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

class SayHi < BaseActivity
  def self.do_execute(context)
    $logger.info 'Saying Hi...'
    context['say']= 'hi'
  end
end

class CheckTrainOnLeft < BaseCondition
  def self.eval_condition(context)
    context['train_on_left']
  end
end

class CheckTrainOnRight < BaseCondition
  def self.eval_condition(context)
    context['train_on_right']
  end
end

class CheckIfWait < BaseCondition
  def self.eval_condition(context)
    context['wait']
  end
end

class RailwayCrossing < BaseAct

  #
  # actor definition
  a1 = single_actor LookLeft
  a2 = single_actor WaitForTrain, true, 'queue1'
  a3 = single_actor LookRight, true, 'queue2'
  a4 = single_actor LookRight, true, 'queue3'
  a5 = single_actor WaitForTrain, true, 'queue4'
  a6 = single_actor CrossNow, true, 'queue5'

  a7 = single_actor SayHi, false

  s1 = switch_actor CheckTrainOnLeft
  s2 = switch_actor CheckIfWait
  s3 = switch_actor CheckTrainOnRight

  #
  # next actor registration
  a1.register_next s1
  a1.register_side_actors a7

  s1.register_next a2, true
  s1.register_next a3, false

  a2.register_next s2

  s2.register_next a4, true

  a3.register_next s3

  s3.register_next a5, true
  s3.register_next a6, false

  #
  # actor registration
  self.start = a1
  self.register_actors a1, a2, a3, a4, a5, a6, a7 #registering all single actors
  self.register_actors s1, s2, s3  #registering all switch actors

end

