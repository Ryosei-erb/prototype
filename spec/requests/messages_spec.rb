require 'rails_helper'

RSpec.describe "Messages", type: :request do
  let!(:taxon) { create(:taxon) }
  let!(:user) { create(:user) }
  let!(:product) { create(:product, user: user, taxons: [taxon]) }
  let!(:room) { create(:room, product: product) }
  let!(:membership) { create(:membership, room: room, user: user) }
  let!(:message) { create(:message, room: room, user: user) }

  describe "POST #messages" do
    before do
      log_in user
      @message_params = { message: {
        content: message.content,
        room_id: message.room.id,
        user_id: message.user.id,
      } }
    end

    it "メッセージが追加される" do
      expect do
        post messages_path, params: @message_params
      end.to change(Message, :count).by(1)
      expect(response).to redirect_to room_path(Message.last.room_id)
    end
  end
end
