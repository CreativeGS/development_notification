FactoryGirl.define do

  factory :email, class: DevelopmentNotification::Email do
    title "test email"
    to_address "dump@example.com"
    subject "test"
    body "body"
    response "1"
    status 1
  end

end
