# require 'rails_helper'
#
# RSpec.feature "Categories", type: :feature do
#   let!(:user) { create(:user) }
#   let!(:taxon) { create(:taxon, name: "bakery") }
#   let!(:another_taxon) { create(:taxon, name: "rice") }
#   let!(:product) { create(:product, user: user, taxons: [taxon]) }
#   let!(:another_product) { create(:product, name: "Platter", user: user, taxons: [taxon]) }
#   let!(:another_taxon_product) do
#     create(:product, name: "curry", user: user,
#                      taxons: [another_taxon])
#   end
#
#   describe "カテゴリー詳細機能" do
#     before do
#       visit category_path(taxon)
#     end
#
#     context "同一カテゴリーに属する商品の場合" do
#       it "表示される" do
#         expect(current_path).to eq category_path(taxon)
#         expect(page).to have_content product.name
#         expect(page).to have_content another_product.name
#         expect(page).to have_no_content another_taxon_product.name
#         click_link product.name
#         expect(current_path).to eq product_path(product)
#         within ".product-right-side" do
#           click_link "一覧ページへ戻る"
#         end
#         expect(current_path).to eq category_path(taxon)
#       end
#     end
#   end
# end
