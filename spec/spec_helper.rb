def set_test_notification_config!
  DevelopmentNotification.configure do |config|
    config.leadersend_username = "email@example.com"
    config.leadersend_api_key = "0933e545acxc063cb8a101a374cc721f"
    config.domain = "example.com"
    config.validate!
  end
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.filter_run_excluding :manual => true

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before :each do
    set_test_notification_config!
  end

end
