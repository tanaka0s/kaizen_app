class ProposalsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new]

  def index
  end

  def new
    @proposal = Proposal.new
  end

  def create
  end
end
