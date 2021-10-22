module Survey
  class CounselorRating
    include Mongoid::Document
    include Mongoid::Timestamps
    include Exportable

    # Find fields by regexp so we do not have to write down every field i.e for validation
    def self.find_fields(search_pattern)
      fields.keys.select { |field_name| field_name =~ search_pattern }
    end

    def self.intervention_contents_fields
      I18n.t('survey.counselor_ratings.form.intervention_contents')
    end
    belongs_to :session, inverse_of: :counselor_rating
    belongs_to :client, inverse_of: :counselor_rating

    field :session_number,       type: Integer
    field :session_duration,     type: Integer
    field :session_date,         type: Time
    field :online_session,       type: Boolean, default: false
    field :cancelled_session,    type: Boolean, default: false
    field :cancellation_reason,  type: String

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

    field :intervention_contents,                    type: Array
    field :intervention_contents_others,             type: String
    field :intervention_contents_others_qualitative, type: String
    field :intervention_contents_others_quantiative, type: String
    field :intervention_contents_others_coaching,    type: String

    # Counselor SRS
    field :counselor_relationship,        type: Integer
    field :counselor_goals_and_topics,    type: Integer
    field :counselor_approach_or_method,  type: Integer
    field :counselor_overall,             type: Integer

    # Counselor characteristics
    field :consultation_code,   type: String
    field :years_of_experience, type: Integer
    field :age,                 type: Integer
    field :gender,              type: String

    # Primary goals
    field :goal_1, type: String
    field :goal_2, type: String
    field :goal_3, type: String

    # last session info
    field :last_session,        type: Boolean
    field :goals_achieved,      type: String
    field :change_of_counselor, type: String
    field :type_of_counseling,  type: String

    find_fields(/^counselor/).map do |field_name|
      validates field_name, presence: true
    end

    def self.intervention_contents_columns
      %i[qualitative quantitative coaching]
    end

    def intervention_contents_cols
      [
        intervention_contents.reject { |x| x unless x.starts_with?('qual') },
        intervention_contents.reject { |x| x unless x.starts_with?('quant') },
        intervention_contents.reject { |x| x unless x.starts_with?('coach') }
      ]
    end

    def first_session?(client)
      Survey::CounselorRating.where(client_id: client.id).count.zero?
    end

    def self.gender_options
      [
        [I18n.t('.survey.counselor_ratings.gender.female'), 'female'],
        [I18n.t('.survey.counselor_ratings.gender.male'), 'male'],
        [I18n.t('.survey.counselor_ratings.gender.other'), 'other']
      ]
    end

    def self.goals(client_id)
      Survey::CounselorRating.where(client_id: client_id, session_number: 1).pluck(:goal_1, :goal_2, :goal_3).flatten!
    end
  end
end
