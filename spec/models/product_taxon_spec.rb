require 'rails_helper'

RSpec.describe ProductTaxon, type: :model do
  let(:taxon) { create(:taxon) }
  let(:product) { create(:product) }
  let(:product_taxons) { create(:product_taxon, product: product, taxon: taxon) }

  it { expect(product_taxons).to be_valid }

  it "taxon_idがあれば有効" do
    product_taxons.taxon_id = nil
    product_taxons.valid?
    expect(product_taxons.errors[:taxon_id]).to include("を入力してください")
  end
end
