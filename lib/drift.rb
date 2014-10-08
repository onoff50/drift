require 'sidekiq'
require_relative 'drift/version'

require_relative 'drift/activity/base_activity'

require_relative 'drift/actor/base_actor'
require_relative 'drift/actor/single_actor'
require_relative 'drift/actor/side_actor'
require_relative 'drift/actor/condition_actor'
require_relative 'drift/actor/switch_actor'

require_relative 'drift/context/base_context'

require_relative 'drift/act/base_act'

require_relative 'drift/helper/drift_helper'

require_relative 'drift/exception/drift_exception'

require_relative 'drift/config/database'


$logger = (defined? logger) ? logger : Logger.new(STDOUT)

Sidekiq.configure_server do |config|
  $logger.info 'INITIALIZING REDIS'
  config.redis = { namespace:  'drift', size: 25,url: "redis://#{DB_DEFAULTS[:host]}:#{DB_DEFAULTS[:port]}/12" }
end

Sidekiq.configure_client do |config|
  $logger.info 'INITIALIZING REDIS'
  config.redis = { namespace:  'drift', size: 1, url: "redis://#{DB_DEFAULTS[:host]}:#{DB_DEFAULTS[:port]}/12" }
end


module Drift
  # Your code goes here...

end

