include Drift
include DriftHelper

class Increment < BaseActivity
  def self.do_execute(context)
    context['number'] +=1
    $logger.info "Incremented to #{context['number']}"
  end
end

class Printer < BaseActivity
  def self.do_execute(context)
    $logger.info "PRINTER"
  end
end

class CheckLimit < BaseCondition
  def self.eval_condition(context)
    context['number'] >= context['limit']
  end
end

class CircularAct < BaseAct

  a1 = single_actor(Increment)
  s1 = switch_actor(CheckLimit)
  a2 = single_actor(Printer)

  self.start = a1
  self.register_actors(a1,s1,a2)

  a1.register_next(s1)
  s1.register_next(a1, false)
  s1.register_next(a2, true)
end
