class ExecutionsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :edit]
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

  def edit
    @execution = Execution.find(params[:id])
  end

  def update
    @execution = Execution.find(params[:id])
    if @execution.update(execution_update_params)
      redirect_to executions_path
    else
      render :edit
    end
  end

  private

  def execution_params
    params.require(:execution).permit(:image, :where, :what, :why, :how, :after_seconds, :after_workers, :after_days, :hourly_wage, :after_man_hours,
                                      :after_costs, :reduced_man_hours, :reduced_costs).merge(user_id: current_user.id, proposal_id: @proposal.id)
  end

  def execution_update_params
    params.require(:execution).permit(:image, :where, :what, :why, :how, :after_seconds, :after_workers, :after_days, :hourly_wage, :after_man_hours,
                                      :after_costs, :reduced_man_hours, :reduced_costs)
  end
end
