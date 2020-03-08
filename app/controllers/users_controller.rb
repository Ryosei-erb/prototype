class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  def show
    @user = User.find(params[:id])
    @product = @user.products.first
    @favorites_products = @user.favorites.map { |f| f.product }
    @currentUserEntry=Membership.where(user_id: current_user.id)
    @userEntry=Membership.where(user_id: @user.id)
    if @user.id == current_user.id
    else
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @entry = Membership.new
      end
    end
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
    params.require(:user).permit(:name, :email, :password)
  end
end
