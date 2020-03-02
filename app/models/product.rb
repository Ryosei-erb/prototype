class Product < ApplicationRecord
  has_many :product_taxons, dependent: :destroy
  has_many :taxons, through: :product_taxons

  accepts_nested_attributes_for :taxons

  has_attached_file :image,
  styles: { product: "680×680>", large: "1200×1200>" }, path: "#{Rails.root}/app/assets/images/:filename"
  validates_attachment_content_type :image, content_type: [ "image/jpeg", "image/gif", "image/png", "image/jpg"]
  validates_attachment_presence :image
end
