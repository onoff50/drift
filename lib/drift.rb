require 'json'
require 'active_support'

require_relative 'drift/version'

require_relative 'drift/activity/base_activity'

require_relative 'drift/condition/base_condition'

require_relative 'drift/actor/single_actor'
require_relative 'drift/actor/switch_actor'

require_relative 'drift/context/base_context'

require_relative 'drift/act/base_act'

require_relative 'drift/helper/drift_helper'

require_relative 'drift/exception/drift_exception'

# require_relative 'drift/config/database'

$logger = (defined? logger) ? logger : Logger.new(STDOUT)

module Drift

  def self.default_worker_options=(hash)
    @default_worker_options = default_worker_options.merge(hash)
  end

  def self.default_worker_options
    defined?(@default_worker_options) ? @default_worker_options : {'app_id' => 'drift_default', 'queue_name' => 'drift_default', 'app_uri' => ''}
  end

end

