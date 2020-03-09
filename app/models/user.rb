class User < ApplicationRecord
  has_many :products
  has_many :favorites
  has_many :messages, dependent: :destroy
  has_many :memberships, dependent: :destroy
  authenticates_with_sorcery!
  mount_uploader :image, ImageUploader
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6}
  validate :image_size

  def image_size
    if image.size > 5.megabytes
      errors.add(:image, "5MB以下のファイルを添付して下さい")
    end
  end
end
