class NotificationRelayJob < ApplicationJob
  queue_as :default

  def perform(notification)
    begin
      ActionCable.server.broadcast "notification_channel_#{notification.recipient}", message: render_notification(notification), code: 'notification'
      notification.update({ seen: true })
    rescue => e
      puts('Error while broadcasting notification: ' + e.to_s)
    end

  end

  private

  def render_notification(notification)
    ApplicationController.renderer.render(partial: 'notifications/notification', locals: { notification: notification })
  end
end
