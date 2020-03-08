Food Share services to be continued.
<div class="container">
  <div class="row">
    <% if @user.id == current_user.id %>
    <% else %>
      <% if @isRoom == true %>
        <p><a href="/rooms/<%= @roomId %>">チャットへ</a>
      <% else %>
        <%= form_for @room do |f| %>
          <%= fields_for @membership do |e| %>
            <%= e.hidden_field :user_id, :value=> @user.id %>
          <% end %>
          <%= f.submit "チャットを始める" %>
        <% end %>
      <% end %>
    <% end %>
  </div>
</div>

@room = Room.create
Membership.create(:room_id => @room.id, :user_id => current_user.id)
Membership.create(params.require(:membership).permit(:user_id, :room_id).merge(:room_id => @room.id))
redirect_to "/rooms/#{@room.id}"


current_user_membership.room_id == user_membership.room_id &&


@current_user_memberships.each do |current_user_membership|
  @user_memberships.each do |user_membership|
    if current_user_membership.room.product_id == @product.id
      @has_Room = true
      @room_id = current_user_membership.room_id
    end
  end
end
unless @has_Room
  @room = Room.new
  @membership = Membership.new
end
