module Survey
  class SessionsController < ApplicationController
    before_action :set_type

    before_action :load_client
    before_action :load_therapists # Loads the list with all available therapists

    def new
      @session = type_class.new(therapist: @client.last_therapist)
    end

    def create
      @session = type_class.new session_params
      @session.client = @client

      @session.therapist = @client.therapist # Ensure we always state which therapist guided the session

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
      type_class = [Survey::SessionRatingScale, Survey::ChildrenSessionRatingScale].find { |x| x.name == params[:type] }
      type_class || 'Survey::Session'
    end

    def type_class
      type
    end

    def load_client
      @client = Client.find(params[:client_id])
    end

    def load_therapists
      @therapists = Therapist.asc(:name)
    end

    def session_params
      required_param = "survey_#{type.name.demodulize.underscore}"
      params.require(required_param).permit(:therapist_id, :relationship, :goals_and_topics, :approach_or_method, :overall, :comment)
    end
  end
end
