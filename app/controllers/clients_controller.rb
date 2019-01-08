require 'csv'

class ClientsController < ApplicationController
  include ActionController::Live

  before_action :http_basic_auth, :csv_header, only: :index
  before_action :find_or_initialize_client, only: :create
  before_action :load_therapists # Loads the list with all available therapists
  before_action :load_client, only: %i[edit update]

  def index
    Client.each do |client|
      client.sessions.each do |session|
        next if session.therapist.blank?

        response.stream.write CSV.generate_line([client.identifier, session.created_at, session.updated_at, session.therapist.name, session.therapist.email,
                                                 session.version, session.class.name, session.relationship, session.goals_and_topics,
                                                 session.approach_or_method, session.overall, session.comment])
      end
    end
  ensure
    response.stream.close
  end

  def show
    @client = Client.find_by(token: params[:token])
    @therapist = Therapist.find_by(token: params[:therapist_token])
    sessions = @client.sessions.where(therapist: @therapist).asc(:created_at)
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

  def find_or_initialize_client
    @client = Client.find_or_initialize_by(identifier: client_params[:identifier].downcase)
  end

  def client_params
    params.require(:client).permit(:identifier, :name, :class_of_age, :therapist_id, :second_step)
  end

  # Set the path depending on kind of survey used for last survey
  def new_client_session_path
    "/clients/#{@client.id}/#{@client.session_type_by_age.name.tableize}/new"
  end

  def load_therapists
    @therapists = Therapist.asc(:name)
  end

  def load_client
    @client = Client.find(params[:id])
  end

  def csv_header
    response.headers['Content-Disposition'] = 'attachment; filename="' + Time.now.strftime('%Y%m%d%H%M') + '.csv"'
    response.headers['Content-Type'] = 'text/csv'
    response.stream.write CSV.generate_line(%w[identifier created_at updated_at therapist_name therapist_email version scale
                                               relationship goals_and_topics approach_or_method overall comment])
  end
end
