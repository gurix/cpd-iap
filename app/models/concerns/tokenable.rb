module Tokenable
  extend ActiveSupport::Concern

  included do
    field :token,              type: String
    field :token_generated_at, type: DateTime

    validates :token, uniqueness: true
    validates :token_generated_at, presence: true, if: :token?

    before_create :reset_token
  end

  def reset_token
    self.token = generate_token(4) until unique_token?
    self.token_generated_at = Time.now
  end

  private

  def generate_token(size)
    SecureRandom.base64(size).downcase.delete('/+=')[0, size]
  end

  def unique_token?
    field = :token
    self.class.where(field => send(field)).blank? && send(field).present?
  end
end
