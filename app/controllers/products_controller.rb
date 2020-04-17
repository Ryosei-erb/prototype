class ProductsController < ApplicationController
  skip_before_action :require_login, only: [:index, :show, :search, :location, :sold, :resale]
  RELATING_PRODUCTS_LIMIT = 4
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
    redirect_to sold_path if @product.state == "sold"

    # 関連商品表示機能
    @relating_products = Product.joins(:taxons).where("product_taxons.taxon_id":
      @product.taxon_ids).where.not(id: @product.id, state: "sold").distinct.
      shuffle.take(RELATING_PRODUCTS_LIMIT)

    # ダイレクトメッセージ機能
    @user = @product.user
    if current_user
      current_user_memberships = Membership.where(user_id: current_user.id)
      current_user_memberships.each do |current_user_membership|
        if current_user_membership.room.product_id == @product.id
          @room_id = current_user_membership.room_id
        else
          @room = Room.new
        end
      end
    end

    # 新規商品表示機能
    @new_release_products = Product.order(created_at: "desc")
      .where.not(id: @product.id, state: "sold").distinct.limit(4)
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

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to root_path
  end

  def search
    @searched_products = Product.joins(:taxons).
      where("taxons.name like ?", "%#{params[:search]}%").
      or(Product.joins(:taxons).
      where("products.name like ?", "%#{params[:search]}%"))
  end

  def location
    @product = Product.find(params[:id])

    # Google Maps表示機能
    @map = @product.map
    @current_user_latitude = params[:latitude]
    @current_user_longitude = params[:longitude]
    @product_latitude = @product.map.latitude
    @product_longitude = @product.map.longitude
    @distance = Geocoder::Calculations.distance_between([@current_user_latitude, @current_user_longitude], [@product_latitude, @product_longitude])

    # 関連商品表示機能
    @relating_products = Product.joins(:taxons).where("product_taxons.taxon_id":
      @product.taxon_ids).where.not(id: @product.id, state: "sold").distinct.
      shuffle.take(RELATING_PRODUCTS_LIMIT)

    # ダイレクトメッセージ機能
    @user = @product.user
    if current_user
      current_user_memberships = Membership.where(user_id: current_user.id)
      current_user_memberships.each do |current_user_membership|
        if current_user_membership.room.product_id == @product.id
          @room_id = current_user_membership.room_id
        else
          @room = Room.new
        end
      end
    end

    # 新規商品表示機能
    @new_release_products = Product.order(created_at: "desc")
      .where.not(id: @product.id, state: "sold").distinct.limit(4)
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

  def checkout
    @card = current_user.cards.first
    @product = Product.find(params[:id])
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(currency: "jpy", amount: @product.price, customer: @card.customer_id)
    redirect_to sold_path(@product)
  end

  def products_params
    params.require(:product).permit(:name, :description, :pickup_times, :image, :price, :taxon_ids,
                                    map_attributes: [:id, :address])
  end
end
