class DiscussionThreadsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_discussion_thread, only: [:show, :edit, :update, :destroy]
  before_action :authorize_thread, only: [:edit, :update, :destroy]

  # GET /projects/:project_id/discussion_threads/new or /discussion_threads/new
  def new
    if params[:project_id]
      @project = Project.find(params[:project_id])
      @discussion_thread = @project.discussion_threads.new
    else
      @discussion_thread = DiscussionThread.new
    end
  end

  # POST /projects/:project_id/discussion_threads or /discussion_threads
  def create
    if params[:project_id]
      @project = Project.find(params[:project_id])
      @discussion_thread = @project.discussion_threads.new(discussion_thread_params)
      @discussion_thread.user = current_user
    else
      @discussion_thread = current_user.discussion_threads.new(discussion_thread_params)
    end

    if @discussion_thread.save
      redirect_to @discussion_thread, notice: "Thread was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /discussion_threads/:id
  def show
    @messages = @discussion_thread.messages.paginate(page: params[:page], per_page: 10)
  end

  # GET /discussion_threads/:id/edit
  def edit
  end

  # PATCH/PUT /discussion_threads/:id
  def update
    if @discussion_thread.update(discussion_thread_params)
      redirect_to @discussion_thread, notice: "Thread was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /discussion_threads/:id
  def destroy
    @discussion_thread.destroy
    redirect_to discussion_threads_url, notice: "Thread was successfully deleted."
  end

  private

  def set_discussion_thread
    @discussion_thread = DiscussionThread.find(params[:id])
  end

  def discussion_thread_params
    params.require(:discussion_thread).permit(:title, :description, :project_id)
  end

  def authorize_thread
    # Only allow the thread creator or a project admin to modify the thread
    membership = @discussion_thread.project&.project_memberships&.find_by(user: current_user)
    unless @discussion_thread.user == current_user || (membership && membership.role == "admin")
      redirect_to discussion_threads_path, alert: "You are not authorized to perform this action."
    end
  end
end
