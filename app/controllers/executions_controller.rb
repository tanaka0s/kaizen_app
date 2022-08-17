class ExecutionsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new]
  def index
    @executions = Execution.includes(:user, :proposal).order('updated_at DESC')
  end

  def new
    @proposal = Proposal.find(params[:proposal_id])
    @execution = Execution.new
  end

  def create
    @proposal = Proposal.find(params[:proposal_id])
    @execution = Execution.new(execution_params)
    if @execution.save
      redirect_to executions_path
    else
      render :new
    end
  end

  private

  def execution_params
    params.require(:execution).permit(:image, :where, :what, :why, :how, :after_seconds, :after_workers, :after_days, :hourly_wage, :after_man_hours,
                                      :after_costs, :reduced_man_hours, :reduced_costs).merge(user_id: current_user.id, proposal_id: @proposal.id)
  end
end
