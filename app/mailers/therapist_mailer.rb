class TherapistMailer < ActionMailer::Base
  include Roadie::Rails::Automatic

  default from: ENV['FROM_EMAIL']
  layout 'mailer'

  def reset_token(therapist_id)
    @therapist = Therapist.find(therapist_id)
    @therapist.reset_token
    @therapist.save

    mail to: @therapist.email, subject: I18n.translate('emails.reset_token.subject', name: @therapist.name)
  end

  def new_client_session(therapist_id, client_id)
    @client = Client.find(client_id)
    @therapist = Therapist.find(therapist_id)

    mail to: @therapist.email, subject: I18n.translate('emails.new_client_session.subject', identifier: @client.identifier)
  end
end
