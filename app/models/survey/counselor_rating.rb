module Survey
  class CounselorRating
    include Mongoid::Document
    include Mongoid::Timestamps
    include Exportable

    # Find fields by regexp so we do not have to write down every field i.e for validation
    def self.find_fields(search_pattern)
      fields.keys.select { |field_name| field_name =~ search_pattern }
    end

    belongs_to :session, inverse_of: :counselor_rating

    field :session_number,   type: Integer
    field :session_duration, type: Integer
    field :session_date,     type: Time

    find_fields(/^session/).map do |field_name|
      validates field_name, presence: true
    end

    # CRQ Content
    field :crq_knowledge_and_skills, type: Integer
    field :crq_motivation,           type: Integer
    field :crq_environment,          type: Integer
    field :crq_activity,             type: Integer

    find_fields(/^crq/).map do |field_name|
      validates field_name, presence: true
    end

    field :intervention_contents,        type: Array
    field :intervention_contents_others, type: String

    # Counselor SRS
    field :counselor_relationship,        type: Integer
    field :counselor_goals_and_topics,    type: Integer
    field :counselor_approach_or_method,  type: Integer
    field :counselor_overall,             type: Integer

    find_fields(/^counselor/).map do |field_name|
      validates field_name, presence: true
    end
  end
end
