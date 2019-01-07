class TherapistsController < ApplicationController
  before_action :load_therapist, only: %i[edit update destroy]
  before_action :http_basic_auth, except: :show

  def new
    @therapist = Therapist.new
  end

  def create
    @therapist = Therapist.new(therapist_params)
    render(:new) && return unless @therapist.save
    flash[:success] = t('.created')
    redirect_to therapists_path
  end

  def edit; end

  def destroy
    flash[:success] = t('.deleted') if @therapist.delete
    redirect_to therapists_path
  end

  def update
    render(:edit) && return unless @therapist.update_attributes(therapist_params)
    flash[:success] = t('.updated')
    redirect_to therapists_path
  end

  def index
    @therapists = Therapist.asc(:name)
  end

  def show
    @therapist = Therapist.find_by(token: params[:token])
  end

  private

  def load_therapist
    @therapist = Therapist.find(params[:id])
  end

  def therapist_params
    params.require(:therapist).permit(:email, :name)
  end
end
