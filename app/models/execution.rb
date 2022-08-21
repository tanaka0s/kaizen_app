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
    validates :after_days, numericality: {only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 365,
                                         message: "is out of setting range"}
    with_options numericality: {only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 2_147_483_647,
                                message: "is out of setting range"} do
      validates :after_seconds
      validates :after_workers
      validates :hourly_wage
      validates :after_costs
      validates :reduced_costs
    end
    with_options length: { minimum: 1, maximum: 10, message: "is out of setting range" } do
      validates :after_man_hours
      validates :reduced_man_hours
    end
  end
end
