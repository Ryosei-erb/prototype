class ProductsController < ApplicationController
  skip_before_action :require_login, only: [:index, :show, :search]
  RELATING_PRODUCTS_LIMIT = 4
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
    @relating_products = Product.eager_load(:taxons).where("product_taxons.taxon_id":
      @product.taxon_ids).where.not("id": @product.id).distinct.
      shuffle.take(RELATING_PRODUCTS_LIMIT)
    @map = @product.map

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

  def new
    @product = Product.new
    @product.taxons.build
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

  def search
    @searched_products = Product.joins(:taxons).
      where("taxons.name like ?", "%#{params[:search]}%").
      or(Product.joins(:taxons).
      where("products.name like ?", "%#{params[:search]}%"))
  end

  def products_params
    params.require(:product).permit(:name, :description, :pickup_times, :image, :price, :taxon_ids,
      map_attributes: [:id, :address])
  end
end
