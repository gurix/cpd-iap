require 'csv'

class ClientsController < ApplicationController
  include ActionController::Live

  before_action :http_basic_auth, only: :index
  before_action :find_or_initialize_client, only: :create
  before_action :load_counselors # Loads the list with all available counselors
  before_action :load_client, only: %i[edit update]

  def index
    sessions =
      if params[:from_date].present? && params[:to_date].present?
        Survey::Session.where(created_at: Time.zone.parse(params[:from_date]).beginning_of_day..Time.zone.parse(params[:to_date]).end_of_day)
      elsif params[:from_date].present?
        Survey::Session.where(created_at: Time.zone.parse(params[:from_date]).beginning_of_day..Time.zone.now.end_of_day)
      else
        Survey::Session.all
      end

    csv_header
    sessions.each do |session|
      next if session.counselor.blank?

      client = Client.find(id: session.client_id)

      response.stream.write CSV.generate_line(client.cols + session.cols + counselor_rating(session) + counselor_rating_intervention_contents(session))
    end
  ensure
    response.stream.close
  end

  def show
    @client = Client.find_by(token: params[:token])
    @counselor = Counselor.find_by(token: params[:counselor_token])
    sessions = @client.sessions.where(counselor: @counselor).asc(:created_at)
    @sessions_by_type =  sessions.group_by(&:_type)
  end

  def edit; end

  def new
    @title =  t('.title')
    @client = Client.new
  end

  def update
    redirect_to(new_client_session_path) && return if @client.update_attributes(client_params)

    render :edit
  end

  def create
    redirect_to(new_client_session_path) && return if @client.persisted? # The client already exists we can proceed directly

    @client.assign_attributes(client_params)
    redirect_to(new_client_session_path) && return if @client.second_step && @client.save

    @title = t('.title', identifier: @client.identifier)
    render :new
  end

  private

  # counselor_rating columns or an equivalent nil array if there is no rating
  def counselor_rating(session)
    session.counselor_rating&.cols(%w[intervention_contents]) ||
      [nil].cycle(Survey::CounselorRating.colnames(%w[intervention_contents]).size).to_a
  end

  # interventions as columns or an equivalent nil array if there is no rating
  def counselor_rating_intervention_contents(session)
    session.counselor_rating&.intervention_contents_cols ||
      [nil].cycle(Survey::CounselorRating.intervention_contents_fields.size).to_a
  end

  def find_or_initialize_client
    @client = Client.find_or_initialize_by(identifier: client_params[:identifier].downcase)
  end

  def client_params
    params.require(:client).permit(:identifier, :first_name, :last_name, :counselor_id, :second_step)
  end

  # Set the path depending on kind of survey used for last survey
  def new_client_session_path
    "/clients/#{@client.id}/survey/session_rating_scales/new"
  end

  def load_counselors
    @counselors = Counselor.asc(:name)
  end

  def load_client
    @client = Client.find(params[:id])
  end

  def csv_header
    response.headers['Content-Disposition'] = 'attachment; filename="' + Time.now.strftime('%Y%m%d%H%M') + '.csv"'
    response.headers['Content-Type'] = 'text/csv'
    response.stream.write CSV.generate_line(Client.colnames + Survey::SessionRatingScale.colnames +
    Survey::CounselorRating.colnames(['intervention_contents']) +
    Survey::CounselorRating.intervention_contents_columns)
  end
end
