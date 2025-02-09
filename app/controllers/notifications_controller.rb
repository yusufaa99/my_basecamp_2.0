class NotificationsController < ApplicationController
  before_action :authenticate_user!

  # GET /notifications
  def index
    @notifications = current_user.notifications.order(created_at: :desc)
  end

  # PATCH /notifications/:id/mark_as_read
  def mark_as_read
    notification = current_user.notifications.find(params[:id])
    notification.update(read: true)
    redirect_to notifications_path, notice: "Notification marked as read."
  end
end
