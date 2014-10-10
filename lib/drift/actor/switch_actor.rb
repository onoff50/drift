module Drift

  class SwitchActor < BaseActor

    attr_accessor :activities, :condition

    def initialize(activities = {}, condition = nil, next_actor_map = {}, async = false)
      super(next_actor_map, async)
      @activities = activities
      @condition = condition
    end

    def do_action(context)
      val = @condition.call(context)

      $logger.info "Switch Val = #{val}"

      activity = @activities[val]

      if activity.blank?
        $logger.info "No activity found for val = #{val}, will use default case."
        activity = @activities[:default]
      end

      raise DriftException, "No default activity found for switch val = #{val}" if activity.blank?

      @current_activity = activity
      activity.perform(context) if activity.present?
    end

    def register_next_for_all(actor)
      @activities.values.each do |activity|
          register_next(activity, actor)
      end
    end

    def to_json
      {
          'json_class'   => self.class.name,
          'data' => {
              'next_actor_map' => @next_actor_map,
              'async' => @async,
              'activities' => @activities.to_json,
              'condition' => @condition#.to_source
          }
      }.to_json
    end

    def self.json_create(json_data_hash)
      new(parse_activity_hash(json_data_hash['activities']), eval(json_data_hash['condition']), json_data_hash['next_actor_map'], json_data_hash['async'])
    end

    def self.parse_activity_hash(activity_json)
      activity_hash = JSON.parse(activity_json)
      activity_hash.each{ |key,class_name| activity_hash[key]=Kernel.const_get(class_name)}
    end

  end

end
