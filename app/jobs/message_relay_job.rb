class MessageRelayJob < ApplicationJob
  def perform(message)
    ActionCable.server.broadcast "matches:#{message.match_id}:messages",
      message: MessageController.render(partial: 'messages/message', locals: { message: message })
  end
end
