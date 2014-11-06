module Drift

  class MessageClient

    attr_accessor :client

    def initialize(app_id, queue_name)
      @client = ScMq::Client::MqClient.new(app_id, queue_name)
    end

    def push(payload, group_id)
      validate_payload(payload)
      send_message(payload, group_id)
    end

    private
    def validate_payload(payload)
      raise(ArgumentError, "Message must be a Hash of the form: { 'context' => {}, 'act_name' => 'RailwayCrossing', 'actor_id' => '4e9f5d7de3147ba801f8d1b6c4a04971'") unless payload.is_a?(Hash)
      raise(ArgumentError, "Message must include a context, act class name and actor id: #{payload.inspect}") if !payload['context'] || !payload['act_name'] || !payload['actor_id']
    end

    def send_message(payload, group_id)
      @client.send_message(payload, "POST", "#{default_worker_options['app_uri']}/execute_actor/", nil, nil, nil, nil, nil, group_id)
    end

  end

end

