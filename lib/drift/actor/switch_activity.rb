module Drift

  class SwitchActivity < BaseActivity

    #todo:write test cases
    #todo: write documentation README

    def initialize(activities = {}, &condition)
      @activities = activities
      @condition = condition
    end

    def act(args = {})
      val = @condition.call(args)
      @activities[val].execute(args)
    end

  end

end