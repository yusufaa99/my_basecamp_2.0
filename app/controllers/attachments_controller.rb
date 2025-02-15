class AttachmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project
  before_action :authorize_user!

  # POST /projects/:project_id/attachments
  def create
    @attachment = @project.attachments.new(attachment_params)
    @attachment.user = current_user

    if @attachment.save
      # Notify all project members except uploader
      @project.members.where.not(id: current_user.id).each do |member|
        Notification.create(
          user: member,
          message: "#{current_user.email} uploaded a new file to #{@project.title}.",
          url: project_path(@project),
          read: false
        )
        NotificationsChannel.broadcast_to(
          member, { count: member.notifications.unread.count }
        )
      end

      redirect_to project_path(@project), notice: "Attachment was successfully added."
    else
      redirect_to project_path(@project), alert: "Failed to add attachment: #{@attachment.errors.full_messages.to_sentence}"
    end
  end

  # DELETE /projects/:project_id/attachments/:id
  def destroy
    @attachment = @project.attachments.find(params[:id])
    
    if @attachment.user == current_user || project_admin?
      @attachment.destroy
      redirect_to project_path(@project), notice: "Attachment was successfully removed."
    else
      redirect_to project_path(@project), alert: "You are not authorized to delete this attachment."
    end
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def attachment_params
    params.require(:attachment).permit(:file, :file_url, :file_format)
  end

  def authorize_user!
    unless @project.members.include?(current_user) || @project.creator == current_user
      redirect_to projects_path, alert: "You are not authorized to add attachments to this project."
    end
  end

  def project_admin?
    @project.creator == current_user || @project.project_memberships.find_by(user: current_user)&.role == "admin"
  end
end
