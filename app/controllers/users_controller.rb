class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  def show
    @user = User.find(params[:id])
    @favorite_products = @user.favorites.map { |f| f.product }
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if !@user.id.nil?
      login(params[:user][:email], params[:user][:password])
      redirect_to products_path
    else
      render :new
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
  end
end
