module Survey
  class SessionRatingScale < Session
    field :version, type: Integer, default: 4

    validates :version, presence: true

    # The real survey fields
    field :relationship,       type: Integer, default: 50
    field :goals_and_topics,   type: Integer, default: 50
    field :approach_or_method, type: Integer, default: 50
    field :overall,            type: Integer, default: 50
    field :comment,            type: String

    validates :relationship,       presence: true
    validates :goals_and_topics,   presence: true
    validates :approach_or_method, presence: true
    validates :overall,            presence: true
  end
end
