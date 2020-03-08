class Room < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :memberships, dependent: :destroy
  belongs_to :product
end
