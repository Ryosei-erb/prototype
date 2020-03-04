class CategoriesController < ApplicationController
  skip_before_action :require_login, only: [:show]
  def show
    @taxon = Taxon.find(params[:id])
    @products = @taxon.products
  end
end
