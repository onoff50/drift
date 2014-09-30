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

require_relative 'factories'

require_relative '../lib/drift'

require File.expand_path(File.dirname(__FILE__) + "/factories")




