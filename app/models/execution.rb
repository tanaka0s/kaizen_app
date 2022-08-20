class Execution < ApplicationRecord
  belongs_to :user
  belongs_to :proposal, dependent: :destroy
  has_one_attached :image

  with_options presence: true do
    validates :image
    validates :where
    validates :what
    validates :why
    validates :how
    validates :after_seconds
    validates :after_workers
    validates :after_days
    validates :hourly_wage
    validates :after_costs
    validates :after_man_hours
    validates :reduced_man_hours
    validates :reduced_costs
  end
end
