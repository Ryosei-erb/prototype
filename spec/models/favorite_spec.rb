require 'rails_helper'

RSpec.describe Favorite, type: :model do
  let(:user) { create(:user)}
  let(:product) { create(:product)}
  let(:favorite) { Favorite.new(:user_id => user.id, :product_id => product.id)}

  it "Favoriteモデルが有効" do
    expect(favorite).to be_valid
  end

  it "user_idがあれば有効" do
    favorite.user_id = nil
    favorite.valid?
    expect(favorite.errors[:user_id]).to include("can't be blank")
  end

  it "product_idがあれば有効" do
    favorite.product_id = nil
    favorite.valid?
    expect(favorite.errors[:product_id]).to include("can't be blank")
  end
end
