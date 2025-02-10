class AttachmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project
  before_action :authorize_user!

  # POST /projects/:project_id/attachments
  def create
    @attachment = @project.attachments.new(attachment_params)
    @attachment.user = current_user

    if @attachment.save
      redirect_to project_path(@project), notice: "Attachment was successfully added."
    else
      redirect_to project_path(@project), alert: "Failed to add attachment: #{@attachment.errors.full_messages.to_sentence}"
    end
  end

  # DELETE /projects/:project_id/attachments/:id
  def destroy
    @attachment = @project.attachments.find(params[:id])
    # Optionally, you can add further authorization here (e.g. only the uploader or a project admin can delete)
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
    # Expecting params like { attachment: { file_url: "...", file_format: "png" } }
    params.require(:attachment).permit(:file_url, :file_format)
  end

  # Ensure that the current user is a member of the project
  def authorize_user!
    unless @project.members.include?(current_user) || @project.creator == current_user
      redirect_to projects_path, alert: "You are not authorized to add attachments to this project."
    end
  end

  def project_admin?
    @project.creator == current_user || @project.project_memberships.find_by(user: current_user)&.role == "admin"
  end
end
