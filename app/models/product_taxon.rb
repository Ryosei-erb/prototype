class ProductTaxon < ApplicationRecord
  belongs_to :product
  belongs_to :taxon
  validates :taxon_id, presence: true
end
