require 'csv'

class ClientsController < ApplicationController
  include ActionController::Live

  before_action :http_basic_auth, only: :index
  before_action :find_or_initialize_client, only: :create
  before_action :load_counselors # Loads the list with all available counselors
  before_action :load_client, only: %i[edit update]

  def index
    csv_header
    Client.each do |client|
      client.sessions.each do |session|
        next if session.counselor.blank?

        counselor_rating = session.counselor_rating&.cols || [nil].cycle(Survey::CounselorRating.colnames.size).to_a
        response.stream.write CSV.generate_line(client.cols +
          session.cols + counselor_rating)
      end
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
    response.stream.write CSV.generate_line(Client.colnames + Survey::SessionRatingScale.colnames + Survey::CounselorRating.colnames)
  end
end
