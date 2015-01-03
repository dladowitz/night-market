class SuppliesController < ApplicationController
  before_action :require_user
  load_and_authorize_resource :event

  def index
    @supplies = @event.supplies
  end
end
