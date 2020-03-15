class ProductsController < ApplicationController
  skip_before_action :require_login, only: [:index, :show, :search, :location, :sold, :resale]
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
    redirect_to sold_path if @product.state == "sold"
  end

  def new
    @product = Product.new
    @product.build_map
  end

  def create
    @product = Product.new(products_params)
    @product.user_id = current_user.id
    if @product.save
      redirect_to product_path(@product.id)
    else
      render "new"
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to root_path
  end

  def search
    @searched_products = Product.where("products.name like ?", "%#{params[:search]}%")
  end

  def location
    @product = Product.find(params[:id])
    @map = @product.map
    @current_user_latitude = params[:latitude]
    @current_user_longitude = params[:longitude]
    @product_latitude = @product.map.latitude
    @product_longitude = @product.map.longitude
    @distance = Geocoder::Calculations.distance_between([@current_user_latitude, @current_user_longitude], [@product_latitude, @product_longitude])

    @user = @product.user
    if current_user
      @current_user_memberships = Membership.where(user_id: current_user.id)
      @current_user_memberships.each do |current_user_membership|
        if current_user_membership.room.product_id == @product.id
          @has_room = true
          @room_id = current_user_membership.room_id
        else
          @room = Room.new
          @membership = Membership.new
        end
      end
    end
  end

  def sold
    @product = Product.find(params[:id])
    @product.state = "sold"
    @product.save
  end

  def resale
    @product = Product.find(params[:id])
    @product.state = "sale"
    @product.save
    redirect_to @product
  end

  def products_params
    params.require(:product).permit(:name, :description, :pickup_times, :image, :price,
      map_attributes: [:id, :address])
  end
end
