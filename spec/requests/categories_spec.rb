require 'rails_helper'

RSpec.describe "Categories", type: :request do
  let!(:product) { create(:product, taxons: [taxon])}
  let!(:taxon) { create(:taxon)}
  describe "GET #show" do
    before do
      get category_path(taxon)
    end
    it "リクエストが成功する" do
      expect(response).to have_http_status 200
    end
  end
end
