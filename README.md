# Drift

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'drift'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install drift

## Usage

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

    context["wsn"] = "WSN#{Random.rand(512)}"

    context["category_id"] = "#{Random.rand(512) + 1000}"

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

    context["audited"] = true

  end

end



class Segregate < BaseAct

  c1 = Proc.new do

    ["supplier_return","liquidate","refurbish"][Random.rand(512)%3]

  end



  #

  # actor definition

  a1 = single_actor FetchData

  a2 = single_actor SupplierReturn

  a3 = single_actor Liquidate

  a4 = single_actor Refurbish

  a5 = single_actor WriteAuditLogs


  s1 = switch_actor c1


  #

  # actor registration

  Segregate.start = a1

  Segregate.register_actors a1, a2, a3, a4, a5

  Segregate.register_actors s1



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


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
