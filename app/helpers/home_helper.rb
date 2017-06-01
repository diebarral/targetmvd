module HomeHelper
  def message_visibility(message)
    message == nil ? 'style=display:none;' : ''
  end
end
