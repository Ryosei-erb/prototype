require 'rails_helper'

RSpec.describe Favorite, type: :model do
  let(:user) { create(:user) }
  let(:product) { create(:product) }
  let(:favorite) { create(:favorite, user: user, product: product) }

  it { expect(favorite).to be_valid }

  it "user_idがあれば有効" do
    favorite.user_id = nil
    favorite.valid?
    expect(favorite.errors[:user_id]).to include("を入力してください")
  end

  it "product_idがあれば有効" do
    favorite.product_id = nil
    favorite.valid?
    expect(favorite.errors[:product_id]).to include("を入力してください")
  end
end
