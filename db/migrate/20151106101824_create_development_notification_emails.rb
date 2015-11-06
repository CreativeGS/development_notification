class CreateDevelopmentNotificationEmails < ActiveRecord::Migration
  def change
    create_table :development_notification_emails do |t|

      t.timestamps
    end
  end
end
