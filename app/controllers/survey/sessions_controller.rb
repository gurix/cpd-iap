module Survey
  class SessionsController < ApplicationController
    before_action :set_type

    before_action :load_client
    before_action :load_counselors # Loads the list with all available counselors

    def new
      @session = type_class.new(counselor: @client.last_counselor)
    end

    def create
      @session = type_class.new session_params
      @session.client = @client

      @session.counselor = @client.counselor # Ensure we always state which counselor guided the session

      if @session.save
        render :create
        return
      end
      render :new
    end

    private

    def set_type
      @type = type
    end

    def type
      type_class = [Survey::SessionRatingScale].find { |x| x.name == params[:type] }
      type_class || 'Survey::Session'
    end

    def type_class
      type
    end

    def load_client
      @client = Client.find(params[:client_id])
    end

    def load_counselors
      @counselors = Counselor.asc(:name)
    end

    def session_params
      required_param = "survey_#{type.name.demodulize.underscore}"
      params.require(required_param).permit(:counselor_id, :relationship, :goals_and_topics, :approach_or_method, :overall, :comment)
    end
  end
end
