module Survey
  class CounselorRatingsController < ApplicationController
    before_action :load_client, :load_session

    def new
      return redirect_to @session.counselor_rating if @session.counselor_rating

      @counselor_rating = CounselorRating.new(session_date: @session.created_at,
                                              session_number: predicted_amount_of_sessions)
    end

    private

    def load_client
      @client = Client.find(params[:client_id])
    end

    def load_session
      @session = @client.sessions.find(params[:session_rating_scale_id])
    end

    def predicted_amount_of_sessions
      @client.sessions.map { |session| session&.counselor_rating&.session_number }.max.to_i + 1
    end
  end
end
