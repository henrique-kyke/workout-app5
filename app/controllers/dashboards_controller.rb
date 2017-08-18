class DashboardsController < ApplicationController
  # before_action :authenticate_user!
  def index
    @athletes = User.paginate(:page => params[:page])
  end
end
