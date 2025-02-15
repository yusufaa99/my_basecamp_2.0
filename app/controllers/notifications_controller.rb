class NotificationsController < ApplicationController
  before_action :authenticate_user!

  # def index
  #   @notifications = current_user.notifications.order(created_at: :desc)
  # end
  def index
    @notifications = current_user.notifications.order(created_at: :desc)
    current_user.notifications.unread.update_all(read: true) # Mark all as read
  end

  def create
    @notification = current_user.notifications.create(notification_params)

    if @notification.persisted?
      NotificationsChannel.broadcast_to(
        current_user, 
        { count: current_user.notifications.unread.count, html: render_notification(@notification) }
      )
      render json: { success: true }
    else
      render json: { success: false, errors: @notification.errors.full_messages }
    end
  end

  def mark_as_read
    @notification = current_user.notifications.find(params[:id])
    @notification.update(read: true)
    redirect_to notifications_path, notice: "Notification marked as read."
  end

  def destroy
    @notification = current_user.notifications.find(params[:id])
    @notification.destroy
    redirect_to notifications_path, notice: "Notification deleted."
  end


  private

  def notification_params
    params.require(:notification).permit(:message, :url)
  end

  def render_notification(notification)
    ApplicationController.renderer.render(partial: "notifications/notification", locals: { notification: notification })
  end
end
