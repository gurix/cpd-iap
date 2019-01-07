class Client
  include Mongoid::Document
  include Mongoid::Timestamps
  include Tokenable

  field :identifier,    type: String
  field :name,          type: String
  field :class_of_age,  type: String

  validates :identifier, presence: true
  validates :identifier, uniqueness: true
  validates :class_of_age, presence: true
  validates :name, presence: true, unless: 'identifier.blank?'

  has_many :sessions, dependent: :destroy, inverse_of: :client, class_name: 'Survey::Session'
  belongs_to :therapist, inverse_of: :clients

  attr_accessor :second_step

  def last_session
    sessions.asc(:created_at).last
  end

  def last_therapist
    last_session&.therapist
  end

  def identifier=(value)
    super(value.downcase)
  end

  def session_type_by_age
    case class_of_age
    when 'child'
      Survey::ChildrenSessionRatingScale
    else
      Survey::SessionRatingScale
    end
  end
end
