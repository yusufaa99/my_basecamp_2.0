module Admin
  class ReportsController < ApplicationController
    before_action :authenticate_user!
    before_action :require_admin

    def index
      # Placeholder: display analytics and reporting information
    end

    private

    def require_admin
      redirect_to root_path, alert: "Access denied." unless current_user.admin?
    end
  end
end
