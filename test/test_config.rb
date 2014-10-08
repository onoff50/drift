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

require_relative 'factories'

require_relative '../lib/drift'
require_relative '../lib/sample/railway_crossing'
require_relative '../lib/sample/noodle_preparation'

require File.expand_path(File.dirname(__FILE__) + "/factories")




