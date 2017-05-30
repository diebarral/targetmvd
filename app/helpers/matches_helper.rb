module MatchesHelper
  def message_class(id)
    id == current_user.id ? 'received' : 'sent'
  end

  def unread_count_visibility(unread)
    unread > 0 ? 'inline-block' : 'none'
  end

  def conversation_icon_classes(has_unread_conversations)
    has_unread_conversations ? 'conversation_icon unread-conversation-badge' : 'conversation_icon'
  end
end
