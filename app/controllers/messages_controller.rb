class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_discussion_thread
  before_action :set_message, only: [:edit, :update, :destroy]
  before_action :authorize_message, only: [:edit, :update, :destroy]

  # POST /discussion_threads/:discussion_thread_id/messages
  def create
    @message = @discussion_thread.messages.new(message_params)
    @message.user = current_user
    if @message.save
      redirect_to discussion_thread_path(@discussion_thread), notice: "Message posted successfully."
    else
      redirect_to discussion_thread_path(@discussion_thread), alert: "Failed to post message."
    end
  end

  # GET /discussion_threads/:discussion_thread_id/messages/:id/edit
  def edit
  end

  # PATCH/PUT /discussion_threads/:discussion_thread_id/messages/:id
  def update
    if @message.update(message_params)
      redirect_to discussion_thread_path(@discussion_thread), notice: "Message updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /discussion_threads/:discussion_thread_id/messages/:id
  def destroy
    @message.destroy
    redirect_to discussion_thread_path(@discussion_thread), notice: "Message deleted successfully."
  end

  private

  def set_discussion_thread
    @discussion_thread = DiscussionThread.find(params[:discussion_thread_id])
  end

  def set_message
    @message = @discussion_thread.messages.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:content)
  end

  def authorize_message
    # Only allow the message creator to edit or delete their message.
    redirect_to discussion_thread_path(@discussion_thread), alert: "You are not authorized to modify this message." unless @message.user == current_user
  end
end
