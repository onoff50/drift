include DriftHelper
include Drift

class Liquidate < BaseActivity
  def self.do_execute(context)
    puts "move inventory into liquidation bulk"
    puts "Put it into available liquidation shelf"
  end
end

class Refurbish < BaseActivity
  def self.do_execute(context)
    puts "move inventory into refurbish bulk"
    puts "Put it into available refurbishment shelf"
  end
end

class FetchData < BaseActivity
  def self.do_execute(context)
    context.add("wsn","WSN#{Random.rand(512)}")
    context.add("category_id","#{Random.rand(512) + 1000}")
  end
end

class SupplierReturn < BaseActivity
  def self.do_execute(context)
    puts "move inventory into SupplierReturn bulk"
    puts "Put it into available SupplierReturn shelf"
  end
end

class WriteAuditLogs < BaseActivity
  def self.do_execute(context)
    puts "update inventory logs of the movement"
    context.add("audited", true)
  end
end


class Segregate < BaseAct
  c1 = Proc.new do
    ["supplier_return","liquidate","refurbish"][Random.rand(512)%3]
  end

  a1 = single_actor(FetchData, self.name, 0)
  a2 = switch_actor({"supplier_return" => SupplierReturn, "liquidate" => Liquidate, "refurbish" => Refurbish}, c1, self.name, 1)
  a3 = single_actor(WriteAuditLogs, self.name, 2)

  @actors = {
      :start => a1,
      0 => {:next_actor_map => {:default => a2}},
      1 => {:next_actor_map => {:default => a3}}
  }
end

