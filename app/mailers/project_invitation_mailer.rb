class ProjectInvitationMailer < ApplicationMailer
    def invite_email
      @invitation = params[:invitation]
      @accept_url = accept_invitation_url(token: @invitation.token)
      mail(to: @invitation.email, subject: "You're invited to join a project on MyBaseCamp2")
    end
  end
  