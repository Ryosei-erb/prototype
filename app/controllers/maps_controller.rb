class MapsController < ApplicationController
  skip_before_action :require_login
  def index
  end
  def search
    @latitude = params[:latitude]
    @longitude = params[:longitude]
    @maps = Map.all.within(3, origin: [params[:latitude], params[:longitude]])
  end
end
