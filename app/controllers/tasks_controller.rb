class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project
  before_action :set_task, only: [:edit, :update, :destroy]

  def index
    @tasks = @project.tasks
  end

  def new
    @task = @project.tasks.new
  end

  def create
    @task = @project.tasks.new(task_params)
    @task.user_id = task_params[:user_id] # Explicitly assign the user_id
  
    if @task.save
      # Notify assigned user
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
      puts @task.errors.full_messages # Debugging: Print errors to the console
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

  def destroy
    @task.destroy
    redirect_to project_path(@project), notice: "Task deleted successfully!"
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

end
