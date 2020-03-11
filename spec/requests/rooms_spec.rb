require 'rails_helper'

RSpec.describe "Rooms", type: :request do
  let!(:taxon) { create(:taxon) }
  let!(:user) { create(:user) }
  let!(:product) { create(:product, user: user, taxons: [taxon]) }
  let!(:room) { create(:room, product: product) }
  let!(:membership) { create(:membership, room: room, user: user) }

  before do
    log_in user
  end

  describe "POST #create" do
    it "Roomが新規登録される" do
      expect do
        post rooms_path, params: { product_id: product.id, user_id: user.id }
      end.to change(Room, :count).by(1)
    end
    it "Membershipsが二つ新規登録される" do
      expect do
        post rooms_path, params: { product_id: product.id, user_id: user.id }
      end.to change(Membership, :count).by(2)
    end
  end

  describe "GET #show" do
    it "リクエストが成功する" do
      get room_path(room)
      expect(response).to have_http_status 200
    end
  end
end
