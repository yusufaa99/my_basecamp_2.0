class DashboardController < ApplicationController
  before_action :authenticate_user!  # This requires that the user is logged in

  def index
    @projects = current_user.projects
    @project = @projects.first # This picks the first project for buttons like "Create Task" or "Invite Members"
  end
end
