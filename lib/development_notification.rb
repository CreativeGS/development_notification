require "development_notification/engine"
require 'leadersend'

module DevelopmentNotification

  class << self
    attr_accessor :config
  end

  def self.configure
    self.config ||= Config.new
    yield(config)
  end

  class Config
    attr_accessor :leadersend_username, :leadersend_api_key, :domain

    def validate!
      raise ArgumentError.new("DevelopmentNotification did not receive all three configuration pieces!") unless @leadersend_username && @leadersend_api_key && @domain
      Config.email_sending
      return true
    end

    def self.email_sending
      Leadersend.configure do |config|
        config.username = DevelopmentNotification.config.leadersend_username
        config.api_key  = DevelopmentNotification.config.leadersend_api_key
      end

      ActionMailer::Base.smtp_settings = {
        :address        => Leadersend.config.host,
        :port           => '587',
        :authentication => :plain,
        :user_name      => Leadersend.config.username,
        :password       => Leadersend.config.api_key,
        :domain         => DevelopmentNotification.config.domain
      }

      ActionMailer::Base.delivery_method = :smtp
      ActionMailer::Base.default_url_options[:host] = DevelopmentNotification.config.domain
    end

  end

end
