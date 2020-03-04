class CategoriesController < ApplicationController
  def show
    @taxon = Taxon.find(params[:id])
    @products = @taxon.products
  end
end
