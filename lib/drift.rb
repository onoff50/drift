require_relative 'drift/version'

require_relative 'drift/activity/base_activity'

require_relative 'drift/actor/base_actor'
require_relative 'drift/actor/single_actor'
require_relative 'drift/actor/condition_actor'
require_relative 'drift/actor/switch_actor'

require_relative 'drift/context/base_context'

require_relative 'drift/act/base_act'

require_relative 'drift/exception/drift_exception'

require 'sidekiq'

$logger = (defined? logger) ? logger : Logger.new(STDOUT)

module Drift
  # Your code goes here...

end
