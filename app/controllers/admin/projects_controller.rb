module Admin
  class ProjectsController < ApplicationController
    before_action :authenticate_user!
    before_action :require_admin

    def index
      # Placeholder: list all projects for admin management
    end

    private

    def require_admin
      redirect_to root_path, alert: "Access denied." unless current_user.admin?
    end
  end
end
