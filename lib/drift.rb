require 'sidekiq'
require 'json'
require 'sourcify'
require 'singleton'

require_relative 'drift/version'

require_relative 'drift/activity/base_activity'

require_relative 'drift/actor/base_actor'
require_relative 'drift/actor/single_actor'
require_relative 'drift/actor/condition_actor'
require_relative 'drift/actor/switch_actor'

require_relative 'drift/context/base_context'

require_relative 'drift/act/base_act'

require_relative 'drift/helper/drift_helper'

require_relative 'drift/exception/drift_exception'

require_relative 'drift/config/database'

require_relative 'drift/metadata/act_metadata'
require_relative 'drift/metadata/base_actor_metadata'
require_relative 'drift/metadata/condition_actor_metadata'
require_relative 'drift/metadata/single_actor_metadata'
require_relative 'drift/metadata/switch_actor_metadata'

require_relative 'drift/middleware/server_middleware'

$logger = (defined? logger) ? logger : Logger.new(STDOUT)

Sidekiq.configure_server do |config|
  $logger.info 'INITIALIZING REDIS'
  config.redis = { namespace:  'drift', size: 25,url: "redis://#{DB_DEFAULTS[:host]}:#{DB_DEFAULTS[:port]}/12" }

  config.server_middleware do |chain|
    chain.add Drift::ServerMiddleware
  end
end

Sidekiq.configure_client do |config|
  $logger.info 'INITIALIZING REDIS'
  config.redis = { namespace:  'drift', size: 1, url: "redis://#{DB_DEFAULTS[:host]}:#{DB_DEFAULTS[:port]}/12" }
end

module Sidekiq

  def self.load_json(string)
    Marshal.load(string)
  end

  def self.dump_json(object)
    Marshal.dump(object)
  end

end


module Drift
  # Your code goes here...

end

