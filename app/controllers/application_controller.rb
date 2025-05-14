class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  protect_from_forgery with: :exception

  before_action :set_project
  # before_action :authenticate_user!

  private

  def set_project
    @project = Project.first # Replace this with logic to find the user's active project
  end

  def require_admin
    unless current_user&.admin?  # Ensures current_user exists and is an admin
      redirect_to root_path, alert: "You are not authorized to access this page."
    end
  end

end
