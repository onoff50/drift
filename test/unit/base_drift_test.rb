require File.expand_path(File.dirname(__FILE__) + '/../test_config')


class SampleTestActivity1 < Drift::BaseActivity
  def self.execute(context)
    context.add('act1', 'SAMPLE TEST ACTIVITY 1')
  end
end

class SampleTestActivity2 < Drift::BaseActivity
  def self.execute(context)
    context.add('act2', 'SAMPLE TEST ACTIVITY 2')
  end
end

class SampleTestActivity3 < Drift::BaseActivity
  def self.execute(context)
    context.add('act3', 'SAMPLE TEST ACTIVITY 3')
  end
end

class SampleTestActivity4 < Drift::BaseActivity
  def self.execute(context)
    context.add('act4', 'SAMPLE TEST ACTIVITY 4')
  end
end

class SampleTestService
  class << self
    def sampleTestMethod(return_value)
      return return_value
    end
  end
end

class BaseDriftTest < ActiveSupport::TestCase
end