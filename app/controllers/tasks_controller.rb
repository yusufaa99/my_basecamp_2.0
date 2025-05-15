class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project
  before_action :set_task, only: [:edit, :update, :destroy]

  # def index
  #   @tasks = @project.tasks
  # end
  def index
    if current_user.admin? || current_user == @project.creator || @project.members.include?(current_user)
      @tasks = @project.tasks
    else
      @tasks = @project.tasks.where(assigned_to: current_user.id)
    end
  end
  

  def new
    @task = @project.tasks.new
  end

  # def create
  #   @task = @project.tasks.new(task_params)
  #   @task.user_id = task_params[:user_id] # Explicitly assign the user_id
  
  #   if @task.save
  #     # Notify assigned user
  #     assigned_user = User.find(@task.user_id)
  #     Notification.create(
  #       user: assigned_user,
  #       message: "You have been assigned a task: #{@task.title}.",
  #       url: project_task_path(@project, @task),
  #       read: false
  #     )
  #     NotificationsChannel.broadcast_to(
  #       assigned_user, { count: assigned_user.notifications.unread.count }
  #     )

  #     redirect_to project_path(@project), notice: "Task was successfully created."
  #   else
  #     puts @task.errors.full_messages # Debugging: Print errors to the console
  #     render :new, status: :unprocessable_entity
  #   end
  # end
  def create
    @task = @project.tasks.new(task_params)
  
    unless current_user.admin? || current_user == @project.creator || @project.members.include?(current_user)
      redirect_to project_path(@project), alert: "You are not allowed to create tasks for this project."
      return
    end
  
    @task.user_id = task_params[:user_id]
  
    if @task.save
      assigned_user = User.find(@task.user_id)
  
      Notification.create(
        user: assigned_user,
        message: "You have been assigned a task: #{@task.title}.",
        url: project_task_path(@project, @task),
        read: false
      )
  
      NotificationsChannel.broadcast_to(
        assigned_user, { count: assigned_user.notifications.unread.count }
      )
  
      redirect_to project_path(@project), notice: "Task was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end
  

  def show
    @task = @project.tasks.find(params[:id])  
  end
  
  
  

  def edit; end

  def update
    if @task.update(task_params)
      redirect_to project_path(@project), notice: "Task updated successfully!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # def destroy
  #   @task.destroy
  #   redirect_to project_path(@project), notice: "Task deleted successfully!"
  # end
  def destroy
    if current_user.admin? || current_user == @task.assigned_user || current_user == @project.creator
      @task.destroy
      redirect_to project_path(@project), notice: "Task deleted successfully!"
    else
      redirect_to project_path(@project), alert: "You are not authorized to delete this task."
    end
  end
  

  private

  def set_project
    @project = Project.find_by(id: params[:project_id])
    redirect_to projects_path, alert: "Project not found." unless @project
  end

  def set_task
    @task = @project.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :due_date, :priority, :assigned_to, :status, :user_id, :project_id)
    # params.require(:task).permit(:title, :description, :due_date, :priority, :assigned_to, :status)
    # params.require(:task).permit(:title, :description, :due_date, :priority, :assigned_to)
  end

  def task_visible_to?(user)
    return false unless user
  
    # Allow access if:
    user.admin? || # The user is an admin
      user == @task.assigned_user || # The user is assigned to the task
      user == @project.creator || # The user owns the project
      @project.members.include?(user) # The user is a project member
  end
  

end
