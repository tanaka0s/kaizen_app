class ProposalsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :edit]
  before_action :set_proposal, only: [:edit, :update]

  def index
    @proposals = Proposal.includes(:user).order('updated_at DESC')
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

  def edit
    @proposal_estimation = ProposalEstimation.new(image: @proposal.image, title: @proposal.title, where: @proposal.where, what: @proposal.what, why: @proposal.why, how: @proposal.how,
                                                  before_seconds: @proposal.before_seconds, before_workers: @proposal.before_workers, before_days: @proposal.before_days,
                                                  before_man_hours: @proposal.before_man_hours, hourly_wage: @proposal.hourly_wage, before_costs: @proposal.before_costs,
                                                  after_seconds: @proposal.estimation.after_seconds, after_workers: @proposal.estimation.after_workers, after_days: @proposal.estimation.after_days,
                                                  after_man_hours: @proposal.estimation.after_man_hours, after_costs: @proposal.estimation.after_costs, hourly_wage: @proposal.estimation.hourly_wage,
                                                  reduced_man_hours: @proposal.estimation.reduced_man_hours, reduced_costs: @proposal.estimation.reduced_costs)
  end

  def update
    @proposal_estimation = ProposalEstimation.new(proposal_params)
    if @proposal_estimation.valid?
      @proposal_estimation.renew(@proposal)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    proposal = Proposal.find(params[:id])
    if current_user == proposal.user
      proposal.destroy
      proposal.image.purge
      redirect_to root_path
    end
  end

  private

  def set_proposal
    @proposal = Proposal.find(params[:id])
  end

  def proposal_params
    params.require(:proposal_estimation).permit(:image, :title, :where, :what, :why, :how, :before_seconds, :before_workers, :before_days, :before_man_hours, :hourly_wage, :before_costs,
                                                :after_seconds, :after_workers, :after_days, :after_man_hours, :after_costs, :reduced_man_hours, :reduced_costs).merge(user_id: current_user.id)
  end
end
