class ProductTaxon < ApplicationRecord
  belongs_to :product
  belongs_to :taxon
end
