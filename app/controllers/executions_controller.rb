class ExecutionsController < ApplicationController
  def index
  end

  def new
    @proposal = Proposal.find(params[:proposal_id])
    @execution = Execution.new
  end

  def create
  end
end
