require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:product) { create(:product) }

  context "有効性と存在性を検証する場合" do
    it { expect(product).to be_valid }

    it "商品名があれば有効" do
      product = build(:product, name: nil)
      product.valid?
      expect(product.errors[:name]).to include("を入力してください")
    end

    it "商品の説明があれば有効" do
      product = build(:product, description: nil)
      product.valid?
      expect(product.errors[:description]).to include("を入力してください")
    end

    it "商品の希望受取時間があれば有効" do
      product = build(:product, pickup_times: nil)
      product.valid?
      expect(product.errors[:pickup_times]).to include("を入力してください")
    end

    it "商品の価格があれば有効" do
      product = build(:product, price: nil)
      product.valid?
      expect(product.errors[:price]).to include("を入力してください")
    end
  end

  context "長さの検証を行う場合" do
    it "商品名が2文字以上であれば有効" do
      product.name = "a"
      product.valid?
      expect(product.errors[:name]).to include("は2文字以上で入力してください")
    end
  end

  context "型の検証を行う場合" do
    it "商品の価格が数字で入力されれば有効" do
      product.price.class == Integer
      product.valid?
      expect(product).to be_valid
    end
  end
end
