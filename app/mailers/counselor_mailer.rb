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
end
