class MessagesController < ApplicationController
  before_action :set_project
  before_action :set_thread
  before_action :authorize_project_member
  before_action :set_project_and_thread

  def create
    Rails.logger.debug "Received params: #{params.inspect}" # 🔍 Debugging
    @project_thread = ProjectThread.find(params[:project_thread_id])
    @message = @project_thread.messages.build(message_params)
    @message.user = current_user
  
    if @message.save
      # Notify all project members except sender
      @project_thread.project.members.where.not(id: current_user.id).each do |member|
        Notification.create(
          user: member,
          message: "#{current_user.email} posted a message in #{@project_thread.title}.",
          url: project_project_thread_path(@project_thread.project, @project_thread),

          read: false
        )
        NotificationsChannel.broadcast_to(
          member, { count: member.notifications.unread.count }
        )
      end

      flash[:notice] = "Message posted!"
      redirect_to request.referer || project_path(@project_thread.project)
    else
      flash[:alert] = "Message failed to send."
      render "project_threads/show"
    end
  end
  
  
  
  def edit
    @message = @thread.messages.find(params[:id])
  end

  def update
    @message = @thread.messages.find(params[:id])

    if @message.update(message_params)
      redirect_to @project, notice: "Message updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    @message = @project_thread.messages.find(params[:id])

    if @message.destroy
      flash[:notice] = "Message deleted successfully."
    else
      flash[:alert] = "Message could not be deleted."
    end

    redirect_to project_path(@project) # 🔥 Redirects to project show page
  end

  
  

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_thread
    @thread = @project.project_threads.find(params[:project_thread_id])
  end

  def set_project_and_thread
    @project = Project.find(params[:project_id])
    @project_thread = @project.project_threads.find(params[:project_thread_id])
  end

  # def message_params
  #   params.require(:message).permit(:content)
  # end

  def message_params
    params.require(:message).permit(:content, :project_thread_id)  # Ensure project_thread_id is permitted
  end

  
  def authorize_project_member
    unless @project.project_memberships.exists?(user_id: current_user.id)
      redirect_to @project, alert: "You are not allowed to post messages."
    end
  end
end
