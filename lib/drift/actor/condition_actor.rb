module Drift

  class ConditionActor < BaseActor

    attr_accessor :then_activity, :else_activity, :condition

    def initialize(then_activity, else_activity, condition, next_actor_map = {}, async = false)
      super(next_actor_map, async)
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
        @else_activity.perform(context)
        @current_activity = @else_activity
      else
        $logger.info 'Skipping else part as ELSE activity not specified'
      end
    end

    def execute_then_activity(context)
      $logger.info "Executing THEN activity #{@then_activity.name}"
      @then_activity.perform(context)
      @current_activity = @then_activity
    end

    def register_next_for_all(actor)
      register_next(@then_activity, actor)
      register_next(@else_activity, actor)
    end

    def to_json
      {
          'json_class'   => self.class.name,
          'data' => {
              'next_actor_map' => @next_actor_map,
              'async' => @async,
              'then_activity' => @then_activity,
              'else_activity' => @else_activity,
              'condition' => @condition.to_source
          }
      }.to_json
    end

    def self.json_create(json_data_hash)
      new(Kernel.const_get(json_data_hash['then_activity']), Kernel.const_get(json_data_hash['else_activity']), eval(json_data_hash['condition']), json_data_hash['next_actor_map'], json_data_hash['async'])
    end

  end

end