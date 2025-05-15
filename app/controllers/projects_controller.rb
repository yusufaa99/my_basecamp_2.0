class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :authorize_project, only: [:edit, :update, :destroy]

  # GET /projects
  def index
    # List projects where the user is a member
    @projects = current_user.projects.order(:created_at)
  end

  # GET /projects/1
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # POST /projects
  def create
    @project = Project.new(project_params)
    # Set the creator to the current user
    @project.creator = current_user

    if @project.save
      # Automatically create a membership for the creator as an admin
      @project.project_memberships.create(user: current_user, role: "admin")
      redirect_to @project, notice: "Project was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
    
  end

  # GET /projects/1/edit
  def edit
  end

  # PATCH/PUT /projects/1
  def update
    if @project.update(project_params)
      redirect_to @project, notice: "Project was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /projects/1
  def destroy
    @project.destroy
    redirect_to projects_path, notice: "Project was successfully deleted."
  end

  def promote_to_admin
    project = Project.find(params[:id])
    user = User.find(params[:user_id])
  
    if project.creator == current_user
      membership = project.project_memberships.find_by(user: user)
      
      if membership && membership.update(role: "admin")
        flash[:notice] = "#{user.email} is now an admin!"
      else
        flash[:alert] = "Failed to update user role."
      end
    else
      flash[:alert] = "You are not authorized to promote users."
    end
  
    redirect_to project_path(project)
  end
  
  def remove_member
    project = Project.find(params[:id])
    user = User.find(params[:user_id])
  
    if project.creator == current_user
      membership = project.project_memberships.find_by(user: user)
      
      if membership && membership.destroy
        flash[:notice] = "#{user.email} has been removed from the project."
      else
        flash[:alert] = "Failed to remove user."
      end
    else
      flash[:alert] = "You are not authorized to remove users."
    end
  
    redirect_to project_path(project)
  end

  def demote_to_member
    @project = Project.find(params[:id])  # Ensure @project is assigned
  
    user = User.find(params[:user_id])
    membership = @project.project_memberships.find_by(user: user)
  
    if membership&.role == "admin" && membership.update(role: "member")
      flash[:notice] = "#{user.email} has been demoted to a member."
    else
      flash[:alert] = "Failed to demote user."
    end
  
    redirect_to project_path(@project)
  end
  

  private

  def set_project
    Rails.logger.debug "Received Params: #{params.inspect}" # Logs params for debugging
    @project = Project.find(params[:project_id] || params[:id])
  end

  def project_params
    params.require(:project).permit(:title, :description, :deadline)
  end

  # Authorization: Only allow project admin (creator or assigned admin) to edit or delete.
  def authorize_project
    membership = @project.project_memberships.find_by(user: current_user)
    unless @project.creator == current_user || (membership && membership.role == "admin")
      redirect_to projects_path, alert: "You are not authorized to perform this action."
    end
  end
end
