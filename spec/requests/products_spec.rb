require 'rails_helper'

RSpec.describe "Products", type: :request do
  let!(:taxon) { create(:taxon)}
  let!(:user) { create(:user)}
  let!(:product) { create(:product, user: user, taxons: [taxon])}
  describe "GET #show" do
    before do
      get product_path(product)
    end
    it "リクエストが成功する" do
      expect(response).to have_http_status 200
    end
  end

  describe "GET #new" do
    context "ログインしている場合" do
      before do
        log_in(user)
        get new_product_path
      end
      it "リクエストが成功する" do
        expect(response).to have_http_status 200
      end
    end
    
    context "ログインしていない場合" do
      before do
        get new_product_path
      end
      it "リダイレクトする" do
        expect(response).to redirect_to new_login_path
      end
    end
  end

  describe "POST #create" do
    context "妥当なパラメータの場合" do
      before do
        log_in(user)
        @product_params = attributes_for(:product)
      end

      it "リクエストが成功する" do
        post products_path, params: { product: @product_params }
        expect(response).to have_http_status 302
      end

      it "商品が追加される" do
        expect{
          post products_path, params: { product: @product_params }
        }.to change{ Product.count }.by(1)
      end

      it "リダイレクトする" do
        post products_path, params: { product: @product_params }
        expect(response).to redirect_to product_path( Product.last )
      end
    end

    context "不正なパラメータの場合" do
      before do
        log_in(user)
      end
      it "データが登録されない" do
        expect{
          post products_path, params: { product: attributes_for(:product, :invalid)}
        }.to change{ Product.count }.by(0)
      end
      it "エラーが表示される" do
        post products_path, params: { product: attributes_for(:product, :invalid)}
        expect(response.body).to include "error"
      end
    end
  end
end
