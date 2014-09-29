# -*- encoding: utf-8 -*-
require File.expand_path('../lib/drift/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Neeraj Singh"]
  gem.email         = ["neerajsi@flipkart.com"]
  gem.description   = "Return flow configuration"
  gem.summary       = "Return flow configuration"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "drift"
  gem.require_paths = ["lib"]
  gem.version       = Drift::VERSION
end
