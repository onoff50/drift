# -*- encoding: utf-8 -*-
require File.expand_path('../lib/drift/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Neeraj Singh"]
  gem.email         = ["neerajsi@flipkart.com"]
  gem.description   = "Return flow configuration"
  gem.summary       = "Return flow configuration"

  gem.files         = `git ls-files`.split($\)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "drift"
  gem.require_paths = ["lib"]
  gem.version       = Drift::VERSION
  gem.add_dependency('activesupport', '~> 3.1.3', '>= 3.1.3')
  gem.add_dependency('graphviz', '~> 0.1.0', '>= 0.1.0')
  gem.add_dependency('ruby-graphviz', '~> 1.2.1', '>= 1.2.1')
  gem.add_dependency('sc-mq', '~> 0.1.3.lock', '>= 0.1.3.lock')
end
