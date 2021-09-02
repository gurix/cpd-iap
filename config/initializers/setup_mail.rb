
ActionMailer::Base.smtp_settings = {
  port:                ENV['SMTP_PORT'],
  address:             ENV['SMTP_HOST'],
  user_name:           ENV['SMTP_USER'],
  password:            ENV['SMTP_PASSWORD'],
  domain:              ENV['SMTP_DOMAIN'],
  authentication:      :plain,
  enable_starttls_auto: true
}
