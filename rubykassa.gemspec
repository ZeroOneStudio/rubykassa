$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rubykassa/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rubykassa"
  s.version     = Rubykassa::VERSION
  s.authors     = ["Sergey Kishenin"]
  s.email       = ["sergey.kishenin@gmail.com"]
  s.homepage    = "http://github.com/ZeroOneStudio/rubykassa"
  s.summary     = "Yet another Ruby wrapper for Robokassa API"
  s.description = "Yet another Ruby wrapper for Robokassa API aimed to make Robokassa integration even more easier"
  
  s.license     = "MIT"

  s.files       = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- spec/rubykassa/*`.split("\n")

  s.add_dependency "rails", ">= 3.0"
  s.add_dependency "multi_xml"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "growl"
  s.add_development_dependency "guard"
  s.add_development_dependency "guard-rspec"
end
