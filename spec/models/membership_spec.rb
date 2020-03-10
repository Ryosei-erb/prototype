require 'rails_helper'

RSpec.describe Membership, type: :model do
  let(:user) { create(:user) }
  let(:room) { create(:room) }
  let(:membership) { create(:membership, user: user, room: room) }

  it { expect(membership).to be_valid }

  it "user_idがあれば有効" do
    membership = build(:membership, user_id: nil)
    membership.valid?
    expect(membership.errors[:user_id]).to include("can't be blank")
  end

  it "room_idがあれば有効" do
    membership = build(:membership, room_id: nil)
    membership.valid?
    expect(membership.errors[:room_id]).to include("can't be blank")
  end
end
