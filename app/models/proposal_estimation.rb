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
    with_options numericality: {only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 2_147_483_647,
                                message: "is out of setting range"} do
      validates :before_seconds
      validates :before_workers
      validates :hourly_wage
      validates :before_costs
      validates :after_seconds
      validates :after_workers
      validates :after_costs
      validates :reduced_costs
    end
    with_options length: { minimum: 1, maximum: 10, message: "is out of setting range" } do
      validates :before_man_hours
      validates :after_man_hours
      validates :reduced_man_hours
    end
    with_options numericality: {only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 365,
                                message: "is out of setting range"} do
      validates :before_days
      validates :after_days
    end
  end

  def save
    proposal = Proposal.create(image: image, user_id: user_id, title: title, where: where, what: what, why: why, how: how,
                               before_seconds: before_seconds, before_workers: before_workers, before_days: before_days,
                               before_man_hours: before_man_hours, hourly_wage: hourly_wage, before_costs: before_costs)

    Estimation.create(proposal_id: proposal.id, after_seconds: after_seconds, after_workers: after_workers,
                      after_days: after_days, after_man_hours: after_man_hours, after_costs: after_costs, hourly_wage: hourly_wage,
                      reduced_man_hours: reduced_man_hours, reduced_costs: reduced_costs)
  end

  def renew(proposal)
    proposal.update(image: image, title: title, where: where, what: what, why: why, how: how,
                    before_seconds: before_seconds, before_workers: before_workers, before_days: before_days,
                    before_man_hours: before_man_hours, hourly_wage: hourly_wage, before_costs: before_costs)

    proposal.estimation.update(after_seconds: after_seconds, after_workers: after_workers, after_days: after_days,
                               after_man_hours: after_man_hours, after_costs: after_costs, hourly_wage: hourly_wage,
                               reduced_man_hours: reduced_man_hours, reduced_costs: reduced_costs)
  end
end
