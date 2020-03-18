require 'rails_helper'

RSpec.describe Taxon, type: :model do
  let(:taxon) { create(:taxon) }

  it { expect(taxon).to be_valid }
  it "名称があれば有効" do
    taxon = build(:taxon, name: nil)
    taxon.valid?
    expect(taxon.errors[:name]).to include("を入力してください")
  end
end
