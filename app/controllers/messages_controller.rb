class MessagesController < ApplicationController
  before_action :set_thread
  before_action :set_message, only: [:edit, :update, :destroy]
  before_action :authorize_member, only: [:create]
  before_action :authorize_owner, only: [:edit, :update, :destroy]

  def create
    @message = @thread.messages.new(message_params)
    @message.user = current_user
    if @message.save
      redirect_to project_path(@thread.project), notice: "Message posted successfully."
    else
      redirect_to project_path(@thread.project), alert: "Message cannot be empty."
    end
  end

  def edit
  end

  def update
    if @message.update(message_params)
      redirect_to project_path(@thread.project), notice: "Message updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @message.destroy
    redirect_to project_path(@thread.project), notice: "Message deleted successfully."
  end

  private

  def set_thread
    @thread = ProjectThread.find(params[:project_thread_id])
  end

  def set_message
    @message = @thread.messages.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:content)
  end

  def authorize_member
    unless @thread.project.project_memberships.exists?(user_id: current_user.id)
      redirect_to project_path(@thread.project), alert: "You must be a project member to post messages."
    end
  end

  def authorize_owner
    redirect_to project_path(@thread.project), alert: "You can only edit or delete your own messages." unless current_user == @message.user
  end
end
