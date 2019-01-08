module Survey
  class Session
    include Mongoid::Document
    include Mongoid::Timestamps

    after_create :send_email

    belongs_to :client, inverse_of: :sessions
    belongs_to :counselor, inverse_of: :sessions

    def send_email
      CounselorMailer.new_client_session(counselor.id, client.id).deliver
    end
  end
end
