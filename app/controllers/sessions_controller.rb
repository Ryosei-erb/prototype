class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  def new
  end

  def create
    @user = login(params[:email], params[:password], params[:remember])
    if @user
      redirect_back_or_to root_path
    else
      render :new
    end
  end

  def destroy
    logout
    redirect_to new_login_path
  end
end
