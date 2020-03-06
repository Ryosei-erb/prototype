class RoomsController < ApplicationController
  skip_before_action :require_login
  def show
    @messages = Message.all
  end
end
