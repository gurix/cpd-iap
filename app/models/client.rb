class Client
  include Mongoid::Document
  include Mongoid::Timestamps
  include Tokenable

  field :identifier,    type: String
  field :name,          type: String

  validates :identifier, presence: true
  validates :identifier, uniqueness: true
  validates :name, presence: true, unless: 'identifier.blank?'

  has_many :sessions, dependent: :destroy, inverse_of: :client, class_name: 'Survey::Session'
  belongs_to :counselor, inverse_of: :clients

  attr_accessor :second_step

  def last_session
    sessions.asc(:created_at).last
  end

  def last_counselor
    last_session&.counselor
  end

  def identifier=(value)
    super(value.downcase)
  end
end
