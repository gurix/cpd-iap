class CounselorsController < ApplicationController
  before_action :load_counselor, only: %i[edit update destroy]
  before_action :http_basic_auth, except: :show

  def new
    @counselor = Counselor.new
  end

  def create
    @counselor = Counselor.new(counselor_params)
    render(:new) && return unless @counselor.save
    flash[:success] = t('.created')
    redirect_to counselors_path
  end

  def edit; end

  def destroy
    flash[:success] = t('.deleted') if @counselor.delete
    redirect_to counselors_path
  end

  def update
    render(:edit) && return unless @counselor.update_attributes(counselor_params)
    flash[:success] = t('.updated')
    redirect_to counselors_path
  end

  def index
    @counselors = Counselor.asc(:name)
  end

  def show
    @counselor = Counselor.find_by(token: params[:token])
  end

  private

  def load_counselor
    @counselor = Counselor.find(params[:id])
  end

  def counselor_params
    params.require(:counselor).permit(:email, :name)
  end
end
