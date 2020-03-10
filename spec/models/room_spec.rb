require 'rails_helper'

RSpec.describe Room, type: :model do
  let(:product) { create(:product) }
  let(:room) { create(:room, product: product) }

  it { expect(room).to be_valid }
end
