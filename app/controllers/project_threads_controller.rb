class ProjectThreadsController < ApplicationController
  before_action :set_project
  before_action :set_thread, only: [:edit, :update, :destroy]
  before_action :authorize_admin, only: [:new, :create, :destroy]

  def new
    @thread = @project.project_threads.new
  end

  def create
    @thread = @project.project_threads.new(thread_params)
    @thread.user = current_user
    if @thread.save
      redirect_to project_path(@project), notice: "Thread created successfully."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @thread.update(thread_params)
      redirect_to project_path(@project), notice: "Thread updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @thread.destroy
    redirect_to project_path(@project), notice: "Thread deleted successfully."
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_thread
    @thread = @project.threads.find(params[:id])
  end

  def thread_params
    params.require(:project_thread).permit(:title)
  end

  def authorize_admin
    redirect_to project_path(@project), alert: "Only project admins can create threads." unless current_user == @project.creator
  end
end
