module Admin
  class SecurityController < ApplicationController
    before_action :authenticate_user!
    before_action :require_admin

    def index
      # Placeholder: manage security settings, such as password policies and two-factor auth
    end

    private

    def require_admin
      redirect_to root_path, alert: "Access denied." unless current_user.admin?
    end
  end
end
