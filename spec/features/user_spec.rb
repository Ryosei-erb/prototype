require 'rails_helper'

RSpec.feature "Users", type: :feature do
  let!(:user) { create(:user, email: "b@b.com") }
  let!(:taxon) { create(:taxon) }
  let!(:product) { create(:product, user: user, taxons: [taxon]) }
  let!(:room) { create(:room, product: product) }

  before do
    visit new_login_path
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: "secret"
    click_button "ログインする"
  end

  describe "商品追加機能" do
    context "商品を追加した場合" do
      it "商品画面に遷移する" do
        visit new_product_path
        fill_in "名称", with: product.name
        fill_in "説明", with: product.description
        fill_in "受取り時間", with: product.pickup_times
        fill_in "価格", with: product.price
        attach_file "product_image", "#{Rails.root}/spec/fixtures/53ma03.jpg" # 第一引数 id
        click_button "出品する"
        visit current_path
        expect(page).to have_button "チャットを始める"
        expect(page).to have_content "関連商品"
      end
    end

    describe "チャット機能" do
      context "チャットを始める場合" do
        it "チャット画面に遷移し、チャットが表示される" do
          visit product_path(product)
          expect(current_path).to eq product_path(product)
          click_button "チャットを始める"
          fill_in "message_content", with: "How are you?"
          click_button "+"
          expect(page).to have_content "How are you?"
        end
      end
    end

    describe "お気に入り機能" do
      context "お気に入りを押した場合" do
        it "お気に入りの表示が変更する" do
          visit product_path(product)
          within ".favoritesBox" do
            expect(page).to have_content "お気に入り登録"
            expect(page).to have_content "0"
            click_link "お気に入り登録"
          end
          visit product_path(product)
          within ".favoritesBox" do
            expect(page).to have_content "「お気に入り」済み"
            expect(page).to have_content "1"
            click_link "「お気に入り」済み"
          end
          visit product_path(product)
          within ".favoritesBox" do
            expect(page).to have_content "お気に入り登録"
            expect(page).to have_content "0"
          end
        end
      end
    end
  end
end
