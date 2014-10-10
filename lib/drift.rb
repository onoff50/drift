require 'sidekiq'
require 'json'
require 'sourcify'

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

$logger = (defined? logger) ? logger : Logger.new(STDOUT)

Sidekiq.configure_server do |config|
  $logger.info 'INITIALIZING REDIS'
  config.redis = {namespace: 'drift', size: 25, url: "redis://#{DB_DEFAULTS[:host]}:#{DB_DEFAULTS[:port]}/12"}
end

Sidekiq.configure_client do |config|
  $logger.info 'INITIALIZING REDIS'
  config.redis = {namespace: 'drift', size: 1, url: "redis://#{DB_DEFAULTS[:host]}:#{DB_DEFAULTS[:port]}/12"}
end

module Sidekiq

  def self.load_json(string)
    class_hash = JSON.parse(string)
    class_hash_args = class_hash['args'][1]

    class_hash_args.each do |key,value|
      class_hash_args[key] = Kernel.const_get(value['json_class']).json_create(value['data'])
    end

    class_hash['args'][1] = class_hash_args
    class_hash
  end

  def self.dump_json(object)
    JSON.generate(object)
  end
end

module Drift
  # Your code goes here...

end

