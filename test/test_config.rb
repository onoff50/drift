require 'test/unit'
require 'mocha'
require 'shoulda'
require 'shoulda-context'
require 'shoulda-matchers'
require 'rack'
require 'logger'
#require 'factory_girl'
require 'active_record'
require 'json'
require 'sidekiq'
require 'sidekiq/testing'

require_relative 'factories'

require_relative '../lib/drift'
require_relative '../lib/sample/railway_crossing'
require_relative '../lib/sample/noodle_preparation'
require_relative '../lib/sample/segregate'
require_relative '../lib/sample/buy_item'

require File.expand_path(File.dirname(__FILE__) + "/factories")




