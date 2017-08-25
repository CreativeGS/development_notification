module DevelopmentNotification
  class Email < ApplicationRecord
    validates :title, presence: true
    validates :to_address, presence: true
    validates :subject, presence: true
    validates :status, presence: true

    def self.send_email(title: nil, to: [], from: nil, fromname: nil, subject: nil, template: nil, template_path: nil, locals: nil)
      mail_object = nil

      [to].flatten.each do |to_email|
        mailer = Leadersend::Mail.new(
          title: title, to: to_email, from: from,
          fromname: fromname, subject: subject, template: template
        )
        leadersend_response_hash = mailer.send

        mail_object = DevelopmentNotification::Email.create_from_leadersend_response_hash(leadersend_response_hash)
        puts "sent email to '#{to_email}'"

      end

      return mail_object

      # TODO add differentiation based on template/template_path argument to use raw html or path accordingly.
    end

    # private

      def self.statuses
        ActiveSupport::HashWithIndifferentAccess.new(new: 0, sent: 1, error: 2)
      end

      def self.create_from_leadersend_response_hash(**hash)
        hash[:status] = self.statuses[hash[:status]]
        sent_mail = new(hash.symbolize_keys)  # .merge(without_protection: true)
        sent_mail.save
        return sent_mail
      end

  end
end
