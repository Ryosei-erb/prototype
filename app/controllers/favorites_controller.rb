class FavoritesController < ApplicationController
  def create
    favorite = current_user.favorites.build(product_id: params[:product_id])
    favorite.save
    redirect_to product_path(params[:product_id])
  end

  def destroy
    favorite = Favorite.find_by(user_id: current_user.id, product_id: params[:product_id])
    favorite.destroy
    redirect_to product_path(params[:product_id])
  end
end
