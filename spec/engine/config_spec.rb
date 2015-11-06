require 'rails_helper'

# rspec ./spec/engine/config_spec.rb
RSpec.describe DevelopmentNotification do
  it "should set configuration" do
    expect(DevelopmentNotification.config.leadersend_username).to eq "email@example.com"
    expect(DevelopmentNotification.config.leadersend_api_key).to eq "0933e545acxc063cb8a101a374cc721f"
    expect(DevelopmentNotification.config.domain).to eq "example.com"
  end

  it "should raise ArgumentError if something is missed" do
    DevelopmentNotification.config = nil
    expect{DevelopmentNotification.configure{|c| c.validate! } }.to raise_error(ArgumentError, /^DevelopmentNotification/ )
  end

  it "should set leadersend gem config after #validate!" do    
    expect(Leadersend.config.username).to eq "email@example.com"
  end
end
