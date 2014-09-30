require File.expand_path(File.dirname(__FILE__) + '/../test_config')


# do_execute not implemented, used to test for exceptions
class MyActivity < Drift:: BaseActivity
end

class AddWater < Drift::BaseActivity
  def self.do_execute(context)
    context.add('water', 'Added 2 cups water to the recipe')
  end
end

class AddNoodles < Drift::BaseActivity
  def self.do_execute(context)
    context.add('noodles', 'Added maggie noodles')
  end
end

class AddSpices < Drift::BaseActivity
  def self.do_execute(context)
    context.add('spices', 'Add maggie ingredients')
  end
end

class CookForFiveMins < Drift::BaseActivity
  def self.do_execute(context)
    context.add('cook', 'Cook on gas for five minutes')
  end
end

class SampleTestService
  class << self
    def sampleTestMethod(args)
      args['water'].blank?
    end
  end
end

class BaseDriftTest < ActiveSupport::TestCase
  include Drift
end