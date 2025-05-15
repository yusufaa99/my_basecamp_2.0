class InvitationsController < ApplicationController
  before_action :authenticate_user!

  # GET /invitations
  def index
    @invitations = ProjectInvitation.where(email: current_user.email, status: "pending")
  end

  # GET /invitations/accept/:token
  def accept
    invitation = ProjectInvitation.find_by(token: params[:token], email: current_user.email, status: "pending")
    if invitation
      # Create a membership for the user on the project.
      # This will allow the user to work on the project.
      invitation.project.project_memberships.create(user: current_user, role: "member")
      # Mark the invitation as accepted
      invitation.update(status: "accepted")
      redirect_to project_path(invitation.project), notice: "Invitation accepted! You have been added to the project."
    else
      redirect_to invitations_path, alert: "Invalid or expired invitation."
    end
  end

  # GET /invitations/decline/:token
  def decline
    invitation = ProjectInvitation.find_by(token: params[:token], email: current_user.email, status: "pending")
    if invitation
      invitation.update(status: "declined")
      redirect_to invitations_path, notice: "Invitation declined."
    else
      redirect_to invitations_path, alert: "Invalid or expired invitation."
    end
  end
end
