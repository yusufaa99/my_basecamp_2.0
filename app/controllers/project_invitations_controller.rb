class ProjectInvitationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project

  # GET /projects/:project_id/project_invitations/new
  def new
    @invitation = @project.project_invitations.new
  end

  # POST /projects/:project_id/project_invitations
  def create
    @invitation = @project.project_invitations.new(invitation_params)
    @invitation.inviter = current_user

    if @invitation.save
      ProjectInvitationMailer.with(invitation: @invitation).invite_email.deliver_later
      
      # Notify the invited user if they already have an account
      user = User.find_by(email: @invitation.email)
      if user
        Notification.create(
          user: user,
          message: "You have been invited to join the project: #{@project.title}.",
          url: project_path(@project),
          read: false
        )
        NotificationsChannel.broadcast_to(
          user, { count: user.notifications.unread.count }
        )
      end

      redirect_to @project, notice: "Invitation sent to #{@invitation.email}."
    else
      render :new, status: :unprocessable_entity
    end    
  end
  

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def invitation_params
    params.require(:project_invitation).permit(:email)
  end
end
