class MessageRelayJob < ApplicationJob
  queue_as :default

  def perform(message)
    begin
      ActionCable.server.broadcast "notification_channel_#{message.destinatary}", message: { match_id: message.match_id, html_element: render_message(message.text) }, code: 2
    rescue Exception => e
      puts('Error while broadcasting message: ' + e.to_s)
    end

  end

  private

  def render_message(message)
    ApplicationController.renderer.render(partial: 'messages/message', locals: { message: message })
  end
end
