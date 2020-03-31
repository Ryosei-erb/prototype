class User < ApplicationRecord
  has_many :products
  has_many :favorites
  has_many :cards
  has_many :messages, dependent: :destroy
  has_many :memberships, dependent: :destroy

  authenticates_with_sorcery!
  mount_uploader :image, ImageUploader

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, uniqueness: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true,
                                    if: -> { new_record? || changes[:crypted_password] }
  validates_confirmation_of :password
  validate :image_size

  def image_size
    if image.size > 5.megabytes
      errors.add(:image, "5MB以下のファイルを添付して下さい")
    end
  end
end
