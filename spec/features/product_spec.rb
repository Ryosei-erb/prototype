require 'rails_helper'

RSpec.feature "Products", type: :feature do
  let!(:user) { create(:user) }
  let!(:taxon) { create(:taxon, name: "bakery") }
  let!(:another_taxon) { create(:taxon, name: "rice") }
  let!(:product) { create(:product, user: user, taxons: [taxon]) }
  let!(:another_product) { create_list(:product, 3, name: "Platter", user: user, taxons: [taxon]) }
  let!(:another_taxon_product) do
    create(:product, name: "curry", user: user,
                     taxons: [another_taxon])
  end

  describe "GET #show" do
    before do
      visit product_path(product)
    end

    it "商品一覧画面が表示される" do
      expect(current_path).to eq product_path(product)
      expect(page).to have_content "検索"
      expect(page).to have_link, href: category_path(product.taxons.first.id)
      expect(page).to have_content "カテゴリー一覧ページへ"
      expect(page).to have_content product.name
      expect(page).to have_content product.price
      expect(page).to have_content product.description
      expect(page).to have_content product.pickup_times
      expect(page).to have_link, href: "/rooms"
    end

    it "関連商品が表示される" do
      within ".relating-products" do
        expect(page).to have_content another_product[0].name
        expect(page).to have_no_content product.name
        expect(page).to have_no_content another_product[0], count: 2
        expect(page).to have_no_content another_taxon_product.name
        expect(page).to have_link, href: product_path(another_product[0].id)
      end
    end
  end

  describe "Header表示" do
    describe "検索機能" do
      before do
        visit root_path
      end

      context "「bakery」と検索した場合" do
        before do
          fill_in "search", with: "bakery"
          click_button "検索"
        end

        it "同一カテゴリーに属する商品は表示される" do
          expect(page).to have_content product.name
          expect(page).to have_content another_product[0].name
          expect(page).to have_no_content another_taxon_product.name
          click_link product.name
          expect(current_path).to eq product_path(product)
        end
      end

      context "「rice」と検索した場合" do
        before do
          fill_in "search", with: "rice"
          click_button "検索"
        end

        it "同一カテゴリーに属する商品は表示される" do
          expect(page).to have_content another_taxon_product.name
          expect(page).to have_no_content product.name
          expect(page).to have_no_content another_product[0].name
        end
      end
    end
  end
end
