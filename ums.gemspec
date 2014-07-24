$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "ums/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "ums"
  s.version     = Ums::VERSION
  s.authors     = ["wangfuhai"]
  s.email       = ["wangfuhai@gmail.com"]
  s.homepage    = "https://github.com/wangfuhai2013/ums-rails"
  s.summary     = "user manage system with rails"
  s.description = "user manage system with rails"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE","Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.0"
  s.add_dependency "will_paginate", "~> 3.0"

  s.add_dependency "utils", "~> 1.0.0"
  
  s.add_development_dependency "sqlite3"
end
