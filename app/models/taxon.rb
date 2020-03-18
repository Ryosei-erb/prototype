class Taxon < ApplicationRecord
  has_many :product_taxons, dependent: :destroy
  has_many :products, through: :product_taxons
  acts_as_nested_set
  validates :name, presence: true
end
