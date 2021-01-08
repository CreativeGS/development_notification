$:.push File.expand_path("../lib", __FILE__)

require "development_notification/version"

Gem::Specification.new do |s|
  s.required_ruby_version = '>= 2'
  s.name        = "development_notification"
  s.version     = DevelopmentNotification::VERSION
  s.authors     = ["Creative"]
  s.email       = ["hi@creative.gs"]
  s.homepage    = "http://creative.gs/"
  s.summary     = "Allow your rails app to send emails to dev team."
  s.description = "Enables sending simple emails to app owners. Wraps [Leadersend](http://www.leadersend.com) mail delivery service and defines a DevelopmentNotification::Email model for logging."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0"
  s.add_dependency 'leadersend', '~> 2.0'

  s.add_development_dependency "pg"
  s.add_development_dependency "pry"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'dotenv-rails'
  s.add_development_dependency "webmock", "~> 2.3.1"
end
