class CounselorMailer < ActionMailer::Base
  include Roadie::Rails::Automatic

  default from: ENV['FROM_EMAIL']
  layout 'mailer'

  def reset_token(counselor_id)
    @counselor = Counselor.find(counselor_id)
    @counselor.reset_token
    @counselor.save

    mail to: @counselor.email, subject: I18n.translate('emails.reset_token.subject', name: @counselor.name)
  end

  def new_client_session(counselor_id, client_id)
    @client = Client.find(client_id)
    @counselor = Counselor.find(counselor_id)

    mail to: @counselor.email, subject: I18n.translate('emails.new_client_session.subject', identifier: @client.identifier)
  end
end
