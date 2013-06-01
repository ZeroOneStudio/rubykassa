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

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.13"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
end
