class ResetCounselorTokensController < ApplicationController
  def new
    @reset_counselor_token = ResetCounselorToken.new
  end

  def create
    @reset_counselor_token = ResetCounselorToken.new reset_counselor_token_params
    if @reset_counselor_token.valid?
      CounselorMailer.reset_token(Counselor.find_by(email: @reset_counselor_token.email)).deliver
      flash.now[:success] = t('.email_sent')
    else
      flash.now[:danger] = @reset_counselor_token.errors.first.last
    end

    render :new
  end

  def reset_counselor_token_params
    params.require(:reset_counselor_token).permit(:email)
  end
end
