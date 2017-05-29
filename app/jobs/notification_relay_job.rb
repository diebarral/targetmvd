class NotificationRelayJob < ApplicationJob
  queue_as :default

  def perform(notification)
    begin

      user = notification.match.get_destinatary(notification.recipient)

      ActionCable.server.broadcast "notification_channel_#{notification.recipient}", message: { html_elem: render_notification(notification), match_id: notification.match_id, user_id: user.id, username: user.name, topic: notification.match.topic.name}, code: 'notification'

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
