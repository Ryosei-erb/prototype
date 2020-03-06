class ProductsController < ApplicationController
  skip_before_action :require_login, only: [:show]
  RELATING_PRODUCTS_LIMIT = 4
  def show
    @product = Product.find(params[:id])
    @messages = Message.all
    @relating_products = Product.eager_load(:taxons).where("product_taxons.taxon_id":
      @product.taxon_ids).where.not("id": @product.id).distinct.shuffle.take(RELATING_PRODUCTS_LIMIT)
  end

  def new
    @product = Product.new
    @product.taxons.build
  end

  def create
    @product = Product.new(products_params)
    @product.user_id = current_user.id
    if @product.save
      binding.pry
      redirect_to product_path(@product.id)
    else
      render "new"
    end
  end

  def search
    @searched_products = Product.joins(:taxons).where("taxons.name like ?", "%#{params[:search]}%").or(Product.joins(:taxons).where("products.name like ?", "%#{params[:search]}%"))
  end

  # def checkout
  #   @product = Product.find(params[:id])
  #   Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
  #   Payjp::Charge.create(currency: "jpy", amount: @product.price, card: params["payjp-token"] )
  #   redirect_to root_path, notice: "Checkout complete"
  # end

  def products_params
    params.require(:product).permit(:name, :description, :pickup_times, :image, :price, :taxon_ids)
  end
end
