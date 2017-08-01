class DashboardsController < ApplicationController
  # before_action :authenticate_user!
  def index
    @athletes = User.all
  end
end
