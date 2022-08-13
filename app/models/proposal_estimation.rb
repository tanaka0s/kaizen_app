class ProposalEstimation
  include ActiveModel::Model
  attr_accessor :image, :user_id, :title, :where, :what, :why, :how, :before_seconds, :before_workers, :before_days, :before_man_hours, :hourly_wage, :before_costs,
                :proposal_id, :after_seconds, :after_workers, :after_days, :after_man_hours, :after_costs, :reduced_man_hours, :reduced_costs

  with_options presence: true do
    validates :image
    validates :user_id
    validates :title
    validates :where
    validates :what
    validates :why
    validates :how
    validates :before_seconds
    validates :before_workers
    validates :before_days
    validates :before_man_hours
    validates :hourly_wage
    validates :before_costs
    validates :after_seconds
    validates :after_workers
    validates :after_days
    validates :after_costs
    validates :after_man_hours
    validates :reduced_man_hours
    validates :reduced_costs
  end

  def save
    proposal = Proposal.create(image: image, user_id: user_id, title: title, where: where, what: what, why: why, how: how,
                               before_seconds: before_seconds, before_workers: before_workers, before_days: before_days,
                               before_man_hours: before_man_hours, hourly_wage: hourly_wage, before_costs: before_costs)

    Estimation.create(proposal_id: proposal.id, after_seconds: after_seconds, after_workers: after_workers,
                      after_days: after_days, after_man_hours: after_man_hours, after_costs: after_costs, hourly_wage: hourly_wage,
                      reduced_man_hours: reduced_man_hours, reduced_costs: reduced_costs)
  end
end
