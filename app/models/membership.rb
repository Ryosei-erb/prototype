class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :room
  validates :user_id, presence: true
end
