module Survey
  class Session
    include Mongoid::Document
    include Mongoid::Timestamps

    after_create :send_email

    belongs_to :client, inverse_of: :sessions
    belongs_to :therapist, inverse_of: :sessions

    def send_email
      TherapistMailer.new_client_session(therapist.id, client.id).deliver
    end
  end
end
