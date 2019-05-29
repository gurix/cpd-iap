class Client
  include Mongoid::Document
  include Mongoid::Timestamps
  include Tokenable

  field :identifier,    type: String
  field :first_name,    type: String
  field :last_name,     type: String

  validates :identifier, presence: true
  validates :identifier, uniqueness: true
  validates :first_name, :last_name, presence: true, unless: proc { |client| client.identifier.blank? }

  has_many :sessions, dependent: :destroy, inverse_of: :client, class_name: 'Survey::Session'
  belongs_to :counselor, inverse_of: :clients

  attr_accessor :second_step

  def name
    "#{first_name} #{last_name}"
  end

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
