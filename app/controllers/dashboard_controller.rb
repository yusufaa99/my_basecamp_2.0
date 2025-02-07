class DashboardController < ApplicationController
  before_action :authenticate_user!  # This requires that the user is logged in

  def index
    # You can add any dashboard logic here (e.g., fetching user-specific data)
  end
end
