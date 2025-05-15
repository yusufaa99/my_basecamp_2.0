module Admin
  class ProjectsController < ApplicationController
    before_action :authenticate_user!
    before_action :require_admin
    before_action :set_project, only: [:show, :edit, :update, :destroy]

    def index
      # Admin can see all projects
      @projects = Project.order(created_at: :desc)

      # Search functionality
      if params[:search].present?
        @projects = @projects.where("title ILIKE ?", "%#{params[:search]}%")
      end

      # Pagination using will_paginate
      @projects = @projects.paginate(page: params[:page], per_page: 10)
    end

    def show
      render 'projects/show'  # Reuse regular project view
    end

    def edit
      render 'projects/edit'  # Reuse regular project edit view
    end

    def update
      if @project.update(project_params)
        redirect_to admin_project_path(@project), notice: 'Project updated successfully.'
      else
        render 'projects/edit'
      end
    end

    def destroy
      @project.destroy
      redirect_to admin_projects_path, notice: 'Project deleted successfully.'
    end

    private

    def set_project
      @project = Project.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:title, :description, :deadline)
    end
  end
end
