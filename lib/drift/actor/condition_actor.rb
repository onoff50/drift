module Drift

  #
  # Condition actor works for both IF THEN ELSE
  # and for IF THEN, which means specifying ELSE activity is optional.
  #  todo: add condition name
  #
  class ConditionActor < BaseActor

    attr_accessor :then_activity, :else_activity, :condition

    def initialize(then_activity, else_activity, condition)
      super()
      @then_activity = then_activity
      @else_activity = else_activity
      @condition = condition
    end

    def do_action(context)
      is_true = @condition.call(context)
      $logger.info "Condition evaluates to #{is_true.inspect}"

      if is_true
        execute_then_activity(context)
      else
        execute_else_activity(context)
      end
    end

    def execute_else_activity(context)
      if else_activity.present?
        $logger.info "Executing ELSE activity #{@else_activity.name}"
        @else_activity.execute(context)
        @current_activity = @else_activity
      else
        $logger.info 'Skipping else part as ELSE activity not specified'
      end
    end

    def execute_then_activity(context)
      $logger.info "Executing THEN activity #{@then_activity.name}"
      @then_activity.execute(context)
      @current_activity = @then_activity
    end

    def to_s
      super + "(then_activity = #{@then_activity}, else_activity = #{@else_activity})"
    end

    def register_next_for_all(actor)
      register_next(@then_activity, actor)
      register_next(@else_activity, actor)
    end

  end

end