module API

  Drift.controllers do

    post "/execute_actor/", :provides => :json do
      $logger.info "POST /execute_actor/ called with #{params}"
      request_body = validate_http_request_body request
      logger.info "Request payload : #{request_body}"
      raise(InvalidDataError, "Message must include a context, act class name and actor id: #{request_body.inspect}") if !request_body['context'] || !request_body['act_name'] || !request_body['actor_id']

      act_class = Kernel.const_get(request_body['act_name'])
      context = Drift::BaseContext.json_create JSON.parse(request_body['context'])
      actor = act_class.get_actor request_body['actor_id']
      actor.perform context

      status 200
    end

  end

end


