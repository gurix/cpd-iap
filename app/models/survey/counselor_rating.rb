module Survey
  class CounselorRating
    include Mongoid::Document
    include Mongoid::Timestamps

    belongs_to :session, inverse_of: :counselor_rating

    field :session_number, type: Integer
    field :session_duration, type: Integer
    field :session_date, type: Time

    validates :session_number, presence: true
    validates :session_duration, presence: true
    validates :session_date, presence: true
  end
end
