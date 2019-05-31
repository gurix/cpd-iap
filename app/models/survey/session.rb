module Survey
  class Session
    include Mongoid::Document
    include Mongoid::Timestamps
    include Exportable

    belongs_to :client, inverse_of: :sessions
    belongs_to :counselor, inverse_of: :sessions
  end
end
