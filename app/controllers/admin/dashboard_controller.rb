module Admin
  class DashboardController < ApplicationController
    before_action :authenticate_user!
    before_action :require_admin

    def index
      @total_users = User.count
      @total_projects = Project.count
      @total_tasks = Task.count
    end

    private

    
    def require_admin
      redirect_to root_path, alert: "You are not authorized to perform this action." unless current_user.admin?
    end
  end
end
