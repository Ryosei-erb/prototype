# require 'rails_helper'
#
# RSpec.describe ProductTaxon, type: :model do
#   let(:taxon) { create(:taxon) }
#   let(:product) { create(:product) }
#   let(:product_taxons) { create(:product_taxon, product: product, taxon: taxon) }
#
#   it { expect(product_taxons).to be_valid }
#
#   # it "product_idがあれば有効" do
#   #   product_taxons.product_id = nil
#   #   product_taxons.valid?
#   #   expect(product_taxons.errors[:product_id]).to include("can't be blank")
#   # end
#
#   it "taxon_idがあれば有効" do
#     product_taxons.taxon_id = nil
#     product_taxons.valid?
#     expect(product_taxons.errors[:taxon_id]).to include("can't be blank")
#   end
# end
