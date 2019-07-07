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
    redirect_to login_path unless @user
  end

  def update
    @user = User.find_by(reset_token: params[:token], email: params[:user][:email])
    redirect_to login_path unless @user
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
end
