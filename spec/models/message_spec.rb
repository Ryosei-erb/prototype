require 'rails_helper'

RSpec.describe Message, type: :model do
  let(:user) { create(:user) }
  let(:room) { create(:room, id: 3) }
  let(:message) { create(:message, user: user, room: room) }

  it { expect(message).to be_valid }
  it "Contentがあれば有効" do
    message = build(:message, content: nil)
    message.valid?
    expect(message.errors[:content]).to include("を入力してください")
  end
end
