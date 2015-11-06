class CreateDevelopmentNotificationEmails < ActiveRecord::Migration
  def change
    create_table :development_notification_emails do |t|
      t.string :title, index: true, null: false
      t.string :to_address, index: true, null: false
      t.string :subject, index: true, null: false
      t.text   :body
      t.text   :response
      t.integer :status, index: true, null: false, default: 0

      t.timestamps
    end
  end
end
