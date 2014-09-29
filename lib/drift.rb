require_relative 'drift/version'

require_relative 'drift/activity/base_activity'

require_relative 'drift/actor/base_actor'
require_relative 'drift/actor/single_actor'
require_relative 'drift/actor/condition_actor'
require_relative 'drift/actor/switch_actor'

require_relative 'drift/context/base_context'

require_relative 'drift/orchestrator/base_orchestrator'

$logger = (defined? logger) ? logger : Logger.new(STDOUT)

module Drift
  # Your code goes here...
  def logger
    Logger.new(STDOUT)
  end

end
