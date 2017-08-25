require 'pry'
require 'factory_girl'
require 'dotenv'
Dotenv.load

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path("../../spec/dummy/config/environment", __FILE__)

ENGINE_RAILS_ROOT=File.join(File.dirname(__FILE__), '../')
Dir[File.join(ENGINE_RAILS_ROOT, "spec/factories/**/*.rb")].each {|f| require f }

# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'webmock'; WebMock.enable!; WebMock.disable_net_connect!(allow_localhost: false)

ActiveRecord::Migration.check_pending!

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!
end
