class Product < ApplicationRecord
  has_many :product_taxons, dependent: :destroy
  has_many :taxons, through: :product_taxons

  accepts_nested_attributes_for :taxons
end
