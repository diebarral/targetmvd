App.notification = App.cable.subscriptions.create "NotificationChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (notification) ->
    if notification.code == 'notification'
      $('#notifications').html("<div class='notification'>#{notification.message}</div>")
      $('#notifications-modal').show()

    else if notification.code == 'message'
      match_id = parseInt($('#match').val())
      if match_id == notification.message.match_id
        $('#conversation-body').append(notification.message.html_element)
        $("#conversation-container").animate({ scrollTop: $("#conversation-container")[0].scrollHeight}, 1000);
      else
        # Increment unread messages count


