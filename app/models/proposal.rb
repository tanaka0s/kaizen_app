class Proposal < ApplicationRecord
  belongs_to :user
  has_one :estimation
end
