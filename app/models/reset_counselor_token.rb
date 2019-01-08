class ResetCounselorToken
  include ActiveModel::Model

  attr_accessor :email

  validates :email, presence: true
  validates :email, email: true

  validate :email_exists

  def email_exists
    errors.add(:email, I18n.t('reset_counselor_tokens.does_not_exist', email: email)) if Counselor.where(email: email).count.zero?
  end
end
