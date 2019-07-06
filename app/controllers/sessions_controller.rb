class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user, notice: "You are now logged in."
    else
      flash.now[:alert] = "Email or password is invalid."
      render :new
    end
  end

  def destroy
  end
end
