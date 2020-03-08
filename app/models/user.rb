class User < ApplicationRecord
  has_many :products
  has_many :favorites
  has_many :messages, dependent: :destroy
  has_many :memberships, dependent: :destroy
  authenticates_with_sorcery!
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6}
end
