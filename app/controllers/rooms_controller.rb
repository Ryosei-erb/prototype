class RoomsController < ApplicationController
  skip_before_action :require_login
  def show
    @room = Room.find(params[:id])
    if Membership.where(user_id: current_user.id, room_id: @room.id).present?
      @messages = @room.messages
      @message = Message.new
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def create
    @room = Room.new
    @room.product_id = params[:product_id]
    @room.memberships.build(user_id: params[:user_id])
    @room.memberships.build(user_id: current_user.id)
    @room.save
    redirect_to @room
  end
end
