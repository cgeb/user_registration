class PasswordResetsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user
      @user.generate_reset_token
      UserMailer.with(user: @user).password_reset_email.deliver_later
      flash[:notice] = "Check your Email for further instructions"
      redirect_to login_path
    else
      flash.now[:alert] = "Email address not found"
      render "new"
    end
  end

  def edit
    @user = User.find_by(reset_token: params[:token], email: params[:email])
    unless @user
      flash[:alert] = "Email or reset token is invalid"
      redirect_to login_path
      return
    end

    if token_expired?
      flash[:alert] = "Token is expired"
      redirect_to login_path
      return
    end
  end

  def update
    @user = User.find_by(reset_token: params[:token], email: params[:user][:email])
    unless @user
      flash[:alert] = "Email or reset token is invalid"
      redirect_to login_path
      return
    end

    if token_expired?
      flash[:alert] = "Token is expired"
      redirect_to login_path
      return
    end

    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User was successfully updated." }
      else
        format.html { render :edit }
      end
    end
  end

  private

    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def token_expired?
      @user.reset_sent_at < 6.hours.ago
    end
end
