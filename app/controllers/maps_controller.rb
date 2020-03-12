class MapsController < ApplicationController
  skip_before_action :require_login
  def index
  end
  def search
    @latitude = params[:latitude].to_f
    @longitude = params[:longitude].to_f
    @maps = Map.all.within(3, origin: [params[:latitude].to_f, params[:longitude].to_f])
  end
end
