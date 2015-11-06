require 'rails_helper'

# rspec ./spec/models/development_notification/email_spec.rb
module DevelopmentNotification
  RSpec.describe Email, type: :model do
    let(:email) { FactoryGirl.create :email }

    describe "Spec" do
      it "should have a valid base factory" do
        expect(email).to be_valid
      end
    end

    describe ".send_email" do
      it "should accept explicit hash arguments and return a mail object" do
        hash = {title: "a", to: "dump@example.com", from: "creative@inbox.lv", fromname: "Creative", subject: "test", template: "ab" }
        expect(DevelopmentNotification::Email.send_email(hash)).to be_valid
      end

      it "should accept implicit hash arguments and return a mail object" do
        expect( DevelopmentNotification::Email.send_email(title: "a", to: "dump@example.com", from: "creative@inbox.lv", fromname: "Creative", subject: "test", template: "ab") ).to be_valid
      end

      it "should perform a test with live creditentials if they are present" do
        expect("it").to eq "xit"
      end
    end

    describe ".create_from_leadersend_response_hash" do
      it "should create an object from OK parameters" do
        hash = { title: "a", to_address: "dump@example.com", subject: "test", body: "body", response: "1", status: "sent" }
        email = DevelopmentNotification::Email.create_from_leadersend_response_hash(hash)
        expect(email).to be_valid
      end
    end
  end
end
