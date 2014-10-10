module Drift
  class BaseActor
    include Sidekiq::Worker

    attr_accessor :next_actor_map, :current_activity, :async

    def initialize(next_actor_map = {}, async = false)
      @next_actor_map = next_actor_map
      @current_activity = nil
      @async = async
    end

    def perform(context, nxt_actor_map = @next_actor_map)
      action context

      puts "inside perform with map #{nxt_actor_map.inspect}"
      puts "inside perform with current_activity #{@current_activity.inspect}"
      puts "current class #{self.class.name}"

      post_action context, nxt_actor_map[@current_activity]
      context
    end

    def action(context)
      $logger.info "#{self.class.name} takes action."
      do_action context
      context
    end

    def post_action(context, nxt_actor_json)

      puts "inside post_action with json #{nxt_actor_json}"

      return unless nxt_actor_json

      puts "inside post_action next"

      nxt_actor_hash = JSON.parse(nxt_actor_json)
      nxt_actor = Kernel.const_get(nxt_actor_hash['json_class']).json_create(nxt_actor_hash['data'])

      if @async
        nxt_actor.class.perform_async(context, nxt_actor.next_actor, @current_activity)
      else
        nxt_actor.perform(context)
      end
    end

    def do_action(context)
      raise DriftException, 'Not Implemented'
    end

    def register_next(activity, actor, async = false)
      @next_actor_map[activity] = actor.to_json
      @async = async
      actor
    end

    def next_actor
      @next_actor_map[@current_activity]
    end

    def to_json
      {
          'json_class'   => self.class.name,
          'data' => {
              'next_actor_map' => @next_actor_map,
              'async' => @async
          }
      }.to_json
    end

    def self.json_create(json_data_hash)
       new(json_data_hash['next_actor_map'], json_data_hash['async'])
    end

  end
end