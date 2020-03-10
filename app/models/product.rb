class Product < ApplicationRecord
  has_many :product_taxons, dependent: :destroy
  has_many :taxons, through: :product_taxons
  belongs_to :user
  has_one :room
  has_many :favorites
  mount_uploader :image, ImageUploader

  validates :name, presence: true, length: { minimum: 2 }
  validates :description, presence: true
  validates :pickup_times, presence: true
  validates :price, presence: true, numericality: { only_integer: true }
  validate :image_size

  def image_size
    if image.size > 5.megabytes
      errors.add(:image, "5MB以下のファイルを添付して下さい")
    end
  end

  def favorited_by?(user)
    favorites.where(user_id: user.id).present?
  end
end
