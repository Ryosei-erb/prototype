class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create, :guest]
  def new
    @user = User.new
  end

  def create
    @user = login(params[:email], params[:password], params[:remember])
    if @user
      redirect_back_or_to products_path
    else
      render :new
    end
  end

  def destroy
    logout
    redirect_to new_login_path
  end

  def guest
    @user = User.find_by(email: "email@email.com")
    login(@user.email, "password")
    redirect_to products_path
  end
end
