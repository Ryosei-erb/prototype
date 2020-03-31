class MapsController < ApplicationController
  skip_before_action :require_login
  def index
  end

  def search
    @latitude = params[:latitude]
    @longitude = params[:longitude]
    @maps = Map.includes(:product).where.not("products.state": "sold").within(3, origin: [params[:latitude], params[:longitude]])
  end
end
