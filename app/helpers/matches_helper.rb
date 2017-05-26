module MatchesHelper
  def message_class(id)
    id == current_user.id ? 'received' : 'sent'
  end
end
