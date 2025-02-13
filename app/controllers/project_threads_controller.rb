class ProjectThreadsController < ApplicationController
  before_action :set_project
  before_action :set_thread, only: [:edit, :update, :destroy]
  before_action :authorize_admin, only: [:new, :create, :edit, :update, :destroy]

  def new
    @thread = @project.project_threads.new
  end

  def create
    @thread = @project.project_threads.new(thread_params)
    @thread.user = current_user  # Assign the creator of the thread

    if @thread.save
      redirect_to @project, notice: "Thread created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @project_thread = ProjectThread.find(params[:id])
    @project = @project_thread.project
  end
  
  def edit
  end

  def update
    if @thread.update(thread_params)
      redirect_to @project, notice: "Thread updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @thread.destroy
    redirect_to @project, notice: "Thread deleted successfully."
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_thread
    @thread = @project.project_threads.find(params[:id])
  end

  def thread_params
    params.require(:project_thread).permit(:title)
  end
  
  def project_thread_params
    params.require(:project_thread).permit(:title, :description)
  end
  

  def authorize_admin
    redirect_to @project, alert: "You are not authorized to perform this action." unless current_user == @project.creator
  end
end
