# rspec spec/models/development_notification/email_spec.rb
module DevelopmentNotification
  RSpec.describe Email, type: :model do
    let(:email) { FactoryGirl.create :email }

    describe "Spec" do
      it "should have a valid base factory" do
        expect(email).to be_valid
      end
    end

    describe ".send_email", manual: true do
      it "accepts explicit hash arguments and returns a mail object" do
        hash = {title: "a", to: "dump@example.com", from: "creative@inbox.lv", fromname: "Creative", subject: "test", template: "ab" }
        expect(DevelopmentNotification::Email.send_email(hash)).to be_valid
      end

      it "accepts implicit hash arguments and returns a mail object" do
        expect( DevelopmentNotification::Email.send_email(title: "a", to: "dump@example.com", from: "creative@inbox.lv", fromname: "Creative", subject: "test", template: "ab") ).to be_valid
      end

      it "accept to: as an array of strings" do
        DevelopmentNotification::Email.destroy_all
        expect( DevelopmentNotification::Email.send_email(title: "a", to: ["dump@example1.com", "dump@example2.com"], from: "creative@inbox.lv", fromname: "Creative", subject: "test", template: "ab") ).to be_valid
        expect( DevelopmentNotification::Email.all.size ).to eq 2
      end

      if ENV['LIVE_LEADERSEND_USERNAME'] && ENV['LIVE_LEADERSEND_KEY']
        it "should perform a test with live creditentials if they are present" do

            DevelopmentNotification.configure do |config|
              config.leadersend_username = ENV['LIVE_LEADERSEND_USERNAME']
              config.leadersend_api_key = ENV['LIVE_LEADERSEND_KEY']
              config.validate!
            end
            expect( DevelopmentNotification::Email.send_email(title: "a", to: "dump@example.com", from: "creative@inbox.lv", fromname: "Creative", subject: "test", template: "ab").status ).to eq 1

        end
      else
        puts "No creditentials in .env, skipping.."
        xit "should perform a test with live creditentials if they are present" do
        end
      end

    end

    describe ".create_from_leadersend_response_hash" do
      it "creates an object from OK parameters" do
        hash = { title: "a", to_address: "dump@example.com", subject: "test", body: "body", response: "1", status: "sent" }
        email = DevelopmentNotification::Email.create_from_leadersend_response_hash(hash)
        expect(email).to be_valid
      end
    end
  end
end
