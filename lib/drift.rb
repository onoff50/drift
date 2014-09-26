require_relative 'drift/version'

require_relative 'drift/activity/base_activity'
require_relative 'drift/actor/base_actor'
require_relative 'drift/actor/single_actor'
require_relative 'drift/actor/condition_actor'
require_relative 'drift/actor/switch_actor'


require_relative 'drift/workflow/base_workflow'

def logger
  @@logger = (defined? @@logger) ? @@logger : Logger.new(STDOUT)
end

module Drift
  # Your code goes here...
  def logger
    Logger.new(STDOUT)
  end

end
