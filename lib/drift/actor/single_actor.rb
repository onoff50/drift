module Drift

  class SingleActor < BaseActor

    attr_accessor :single_activity

    def initialize(activity, current_act, seq, async)
      super(current_act, seq, async)
      @single_activity = activity
    end

    def do_action(context)
      @single_activity.perform(context)
      @single_activity
    end

  end

end