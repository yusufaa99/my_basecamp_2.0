class NotificationsChannel < ApplicationCable::Channel
  def subscribed
    stream_for current_user  # Stream notifications specific to the user
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
