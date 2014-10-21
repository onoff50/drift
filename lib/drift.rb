require 'sidekiq'
require 'json'
require 'sourcify'

require_relative 'drift/version'

require_relative 'drift/activity/base_activity'

require_relative 'drift/actor/single_actor'
require_relative 'drift/actor/switch_actor'

require_relative 'drift/context/base_context'

require_relative 'drift/act/base_act'

require_relative 'drift/helper/drift_helper'

require_relative 'drift/exception/drift_exception'

require_relative 'drift/config/database'

require_relative 'drift/middleware/server_middleware'
require_relative 'drift/middleware/client_middleware'

$logger = (defined? logger) ? logger : Logger.new(STDOUT)

Sidekiq.configure_server do |config|
  $logger.info 'INITIALIZING REDIS'
  config.redis = { namespace:  'drift', size: 25,url: "redis://#{DB_DEFAULTS[:host]}:#{DB_DEFAULTS[:port]}/12" }

  config.server_middleware do |chain|
    chain.add Drift::ServerMiddleware
  end

  config.client_middleware do |chain|
    chain.add Drift::ClientMiddleware
  end
end

Sidekiq.configure_client do |config|
  $logger.info 'INITIALIZING REDIS'
  config.redis = { namespace:  'drift', size: 1, url: "redis://#{DB_DEFAULTS[:host]}:#{DB_DEFAULTS[:port]}/12" }

  config.client_middleware do |chain|
    chain.add Drift::ClientMiddleware
  end
end

module Sidekiq

  def self.load_json(string)
    class_hash = JSON.parse(string)
    class_hash_context = class_hash['args'][0]
    class_hash['args'][0] = BaseContext.json_create class_hash_context
    class_hash_metadata = class_hash['args'][1]
    class_hash['args'][1] = Kernel.const_get(class_hash_metadata['json_class']).json_create(class_hash_metadata['data'])
    class_hash
  end

  def self.dump_json(object)
    JSON.generate(object)
  end

end


module Drift

end

