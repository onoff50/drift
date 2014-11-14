include Drift

class Liquidate < BaseActivity
  def self.do_execute(context)
    $logger.debug "move inventory into liquidation bulk"
    $logger.debug "Put it into available liquidation shelf"
  end
end

class Refurbish < BaseActivity
  def self.do_execute(context)
    $logger.debug "move inventory into refurbish bulk"
    $logger.debug "Put it into available refurbishment shelf"
  end
end

class FetchData < BaseActivity
  def self.do_execute(context)
    context["wsn"] = "WSN#{Random.rand(512)}"
    context["category_id"] = "#{Random.rand(512) + 1000}"
  end
end

class SupplierReturn < BaseActivity
  def self.do_execute(context)
    $logger.debug "move inventory into SupplierReturn bulk"
    $logger.debug "Put it into available SupplierReturn shelf"
  end
end

class WriteAuditLogs < BaseActivity
  def self.do_execute(context)
    $logger.debug "update inventory logs of the movement"
    context["audited"] = true
  end
end

class CheckBulk < BaseCondition
  def self.eval_condition(context)
    ["supplier_return","liquidate","refurbish"][Random.rand(512)%3]
  end
end

class Segregate < BaseAct
  #
  # actor definition
  a1 = single_actor FetchData
  a2 = single_actor SupplierReturn
  a3 = single_actor Liquidate
  a4 = single_actor Refurbish
  a5 = single_actor WriteAuditLogs

  s1 = switch_actor CheckBulk

  #
  # actor registration
  self.start = a1
  self.register_actors a1, a2, a3, a4, a5
  self.register_actors s1

  #
  # next actor registration
  a1.register_next s1

  s1.register_next a2, "supplier_return"
  s1.register_next a3, "liquidate"
  s1.register_next a4, "refurbish"

  a2.register_next a5
  a3.register_next a5
  a4.register_next a5

end
