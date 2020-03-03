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

  def products_params
    params.require(:product).permit(:name, :description, :pickup_times, taxons_attributes: [:id, :name])
  end
end
