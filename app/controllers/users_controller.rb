class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  def show
    @user = User.find(params[:id])
    @favorites_products = @user.favorites.map { |f| f.product }
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to new_product_path
    else
      render :new
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :image)
  end
end
