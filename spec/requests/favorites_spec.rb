require 'rails_helper'

RSpec.describe "Favorites", type: :request do
  let!(:user) { create(:user)}
  let!(:taxon) { create(:taxon)}
  let!(:product) { create(:product, user: user, taxons: [taxon] )}
  let!(:favorite) { create(:favorite, user: user, product: product )}
  describe "POST favorites#create" do
    context "ログインしている場合" do
      before do
        log_in user
      end
      it "お気に入り登録がされる" do
        expect {
          post product_favorites_path(product)
        }.to change{ Favorite.count }.by(1)
      end
    end
  end

  describe "DELETE favorite#destroy" do
    context "ログインしている場合" do
      before do
        log_in user
      end
      it "お気に入りを削除する" do
        expect{
          delete product_favorites_path(product)
        }.to change{ Favorite.count }.by(-1)
      end
    end
  end
end
