class Proposal < ApplicationRecord
  belongs_to :user
  has_one :estimation, dependent: :destroy
  has_one_attached :image
  has_one :execution
  has_many :comments
end
