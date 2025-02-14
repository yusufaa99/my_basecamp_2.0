class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  protect_from_forgery with: :exception

  before_action :set_project

  private

  def set_project
    @project = Project.first # Replace this with logic to find the user's active project
  end

end
