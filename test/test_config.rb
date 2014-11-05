require 'test/unit'
require 'mocha'
require 'shoulda'
require 'shoulda-context'
require 'shoulda-matchers'
require 'rack'
require 'logger'
require 'active_record'
require 'json'

require_relative 'factories'

require_relative '../lib/drift'
require_relative '../lib/sample/railway_crossing'
require_relative '../lib/sample/noodle_preparation'
require_relative '../lib/sample/segregate'
require_relative '../lib/sample/buy_item'
require_relative '../lib/sample/circular_act'

require_relative '../lib/drift/testing'

require File.expand_path(File.dirname(__FILE__) + "/factories")




