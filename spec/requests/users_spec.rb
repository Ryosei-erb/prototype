require 'rails_helper'

RSpec.describe "Users", type: :request do
  let!(:user) { create(:user) }
  let!(:taxon) { create(:taxon) }
  let!(:product) { create(:product, user: user, taxons: [taxon]) }

  describe "GET #show" do
    before do
      log_in(user)
      get user_path(user)
    end

    it "リクエストが成功する" do
      expect(response).to have_http_status 200
    end
  end

  describe "GET #new" do
    before do
      get signup_path
    end

    it "リクエストが成功する" do
      expect(response).to have_http_status 200
    end
  end

  describe "POST #create" do
    context "妥当なパラメータの場合" do
      before do
        @user_params = attributes_for(:user)
      end

      it "リクエストが成功する" do
        post users_path, params: { user: @user_params }
        expect(response).to have_http_status 302
      end
      it "ユーザーが登録される" do
        expect do
          post users_path, params: { user: @user_params }
        end.to change(User, :count).by(1)
      end
      it "リダイレクトする" do
        post users_path, params: { user: @user_params }
        expect(response).to redirect_to new_product_path
      end
    end

    context "不正なパラメータの場合" do
      before do
        @failed_params = attributes_for(:user, :invalid)
      end

      it "データが登録されない" do
        expect do
          post users_path, params: { user: @failed_params }
        end.to change(User, :count).by(0)
        expect(response).to render_template("users/new")
      end
    end
  end
end
