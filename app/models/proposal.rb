class Proposal < ApplicationRecord
  belongs_to :user
  has_one :estimation
  has_one_attached :image
end
