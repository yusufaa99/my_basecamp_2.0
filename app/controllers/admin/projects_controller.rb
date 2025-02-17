module Admin
  class ProjectsController < ApplicationController
    before_action :authenticate_user!
    before_action :require_admin

    def index
      @projects = Project.order(created_at: :desc) # List all projects for admin
    
      # Apply search filter if a search term is present
      if params[:search].present?
        @projects = @projects.where("name ILIKE ?", "%#{params[:search]}%")
      end
    
      # Add pagination (using Kaminari or WillPaginate)
      # @projects = @projects.page(params[:page]).per(10)     # Kaminar
      @projects = Project.order(:id).paginate(page: params[:page], per_page: 10)    # WillPaginate
      # @projects = Project.paginate(page: params[:page], per_page: 10)


    end
    

    private

    def require_admin
      redirect_to root_path, alert: "Access denied." unless current_user.admin?
    end
  end
end
