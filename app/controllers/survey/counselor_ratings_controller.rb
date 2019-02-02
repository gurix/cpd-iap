module Survey
  class CounselorRatingsController < ApplicationController
    before_action :load_client, :load_session

    def new
      return redirect_to edit_client_survey_session_rating_scale_counselor_rating_path(@client, @session) if @session.counselor_rating

      @counselor_rating = CounselorRating.new(session_date: @session.created_at,
                                              session_number: predicted_amount_of_sessions)
    end

    def create
      @counselor_rating = CounselorRating.new counselor_rating_params.merge(session: @session)
      flash[:now] = t('survey.counselor_ratings.saved') if
      flash_message_for(@counselor_rating.save)
      render :new
    end

    def edit
      @counselor_rating = @session.counselor_rating
    end

    def update
      @counselor_rating = @session.counselor_rating
      flash_message_for(@counselor_rating.update_attributes(counselor_rating_params))
      render :edit
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

    def counselor_rating_params
      params.require(:survey_counselor_rating).permit(CounselorRating.fields.keys)
    end

    def flash_message_for(saved)
      state = saved ? :success : :error
      flash.now[state] = t("shared.#{state}")
    end
  end
end
