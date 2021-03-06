module Survey
  class SessionRatingScale < Session
    after_create :send_email

    field :version, type: Integer, default: 1

    has_one :counselor_rating, inverse_of: :session, class_name: 'Survey::CounselorRating'

    validates :version, presence: true

    # The real survey fields
    field :relationship,       type: Integer
    field :goals_and_topics,   type: Integer
    field :approach_or_method, type: Integer
    field :overall,            type: Integer

    validates :relationship,       presence: true
    validates :goals_and_topics,   presence: true
    validates :approach_or_method, presence: true
    validates :overall,            presence: true

    def send_email
      CounselorMailer.new_client_session(id).deliver
    end
  end
end
