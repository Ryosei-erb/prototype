require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:product) { create(:product, user: user) }
  let!(:user) do
    create(:user, name: "user_a", email: "user_a@user.com",
                  password: "password", password_confirmation: "password")
  end

  context "有効性と存在性を検証する場合" do
    it { expect(user).to be_valid }

    it "ユーザーネームがあれば有効" do
      user = build(:user, name: nil)
      user.valid?
      expect(user.errors[:name]).to include("を入力してください")
    end

    it "メールアドレスがあれば有効" do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end
  end

  context "長さの検証を行う場合" do
    it "ユーザーネームが51字以上であれば無効" do
      user.name = "a" * 51
      user.valid?
      expect(user.errors[:name]).to include("は50文字以内で入力してください")
    end

    it "メールアドレスが256字以上であれば無効" do
      user.email = "a" * 256
      user.valid?
      expect(user.errors[:email]).to include("は255文字以内で入力してください")
    end
  end

  context "メールアドレスの書式の検証を行う場合" do
    it "正しい書式であれば有効" do
      valid_addresses = %w(
        user@example.com USER@foo.COM A_US-ER@foo.bar.org
        first.last@foo.jp alice+bob@baz.cn
      )
      valid_addresses.each do |valid_address|
        user.email = valid_address
        expect(user).to be_valid
      end
    end

    it "不正な書式であれば無効" do
      invalid_addresses = %w(
        user@example,com user_at_foo.org user.name@example.
        foo@bar_baz.com foo@bar+baz.com
      )
      invalid_addresses.each do |invalid_address|
        user.email = invalid_address
        user.valid?
        expect(user.errors[:email]).to include("は不正な値です")
      end
    end
  end

  context "一意性を検証したい場合" do
    before do
      create(:user, email: "validemail@valid.com")
    end

    it "重複したメールアドレスなら無効" do
      user = build(:user, email: "validemail@valid.com")
      user.valid?
      expect(user.errors[:email]).to include("はすでに存在します")
    end

    it "大文字も同様に無効" do
      user = build(:user, email: "validemail@valid.com")
      user.email.upcase
      user.valid?
      expect(user.errors[:email]).to include("はすでに存在します")
    end
  end
end
