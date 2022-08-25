class ExecutionsController < ApplicationController
  before_action :set_proposal_id, only: [:new, :create]
  before_action :set_execution, only: [:edit, :update]
  def index
    @executions = if params[:sort_costs]
                    Execution.includes(:user, :proposal).order('reduced_costs DESC')
                  else
                    Execution.includes(:user, :proposal).order('updated_at DESC')
                  end
  end

  def new
    @execution = Execution.new
  end

  def create
    @execution = Execution.new(execution_params)
    if @execution.save
      redirect_to executions_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @execution.update(execution_update_params)
      redirect_to executions_path
    else
      render :edit
    end
  end

  def destroy
    execution = Execution.find(params[:id])
    if current_user == execution.user
      execution.destroy
      execution.image.purge
      redirect_to executions_path
    end
  end

  private

  def set_proposal_id
    @proposal = Proposal.find(params[:proposal_id])
  end

  def set_execution
    @execution = Execution.find(params[:id])
  end

  def execution_params
    params.require(:execution).permit(:image, :where, :what, :why, :how, :after_seconds, :after_workers, :after_days, :hourly_wage, :after_man_hours,
                                      :after_costs, :reduced_man_hours, :reduced_costs).merge(user_id: current_user.id, proposal_id: @proposal.id)
  end

  def execution_update_params
    params.require(:execution).permit(:image, :where, :what, :why, :how, :after_seconds, :after_workers, :after_days, :hourly_wage, :after_man_hours,
                                      :after_costs, :reduced_man_hours, :reduced_costs)
  end
end
