class ProposalsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new]

  def index
    @proposals = Proposal.includes(:user).order("updated_at DESC")
  end

  def new
    @proposal_estimation = ProposalEstimation.new
  end

  def create
    @proposal_estimation = ProposalEstimation.new(proposal_params)
    if @proposal_estimation.valid?
      @proposal_estimation.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def proposal_params
    params.require(:proposal_estimation).permit(:image, :title, :where, :what, :why, :how, :before_seconds, :before_workers, :before_days, :before_man_hours, :hourly_wage, :before_costs,
                                                :after_seconds, :after_workers, :after_days, :after_man_hours, :after_costs, :reduced_man_hours, :reduced_costs).merge(user_id: current_user.id)
  end
end
