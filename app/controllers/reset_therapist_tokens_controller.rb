class ResetTherapistTokensController < ApplicationController
  def new
    @reset_therapist_token = ResetTherapistToken.new
  end

  def create
    @reset_therapist_token = ResetTherapistToken.new reset_therapist_token_params
    if @reset_therapist_token.valid?
      TherapistMailer.reset_token(Therapist.find_by(email: @reset_therapist_token.email)).deliver
      flash.now[:success] = t('.email_sent')
    else
      flash.now[:danger] = @reset_therapist_token.errors.first.last
    end

    render :new
  end

  def reset_therapist_token_params
    params.require(:reset_therapist_token).permit(:email)
  end
end
