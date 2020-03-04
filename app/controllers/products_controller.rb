class ProductsController < ApplicationController
  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
    @product.taxons.build
  end

  def create
    @product = Product.new(products_params)
    if @product.save
      redirect_to product_path(@product.id)
    else
      render "new"
    end
  end

  def checkout
    @product = Product.find(params[:id])
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(currency: "jpy", amount: @product.price, card: params["payjp-token"] )
    redirect_to root_path, notice: "Checkout complete"
  end

  def products_params
    params.require(:product).permit(:name, :description, :pickup_times, :image, :price, :taxon_ids)
  end
end
