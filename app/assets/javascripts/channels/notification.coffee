App.notification = App.cable.subscriptions.create "NotificationChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (notification) ->
    # Called when there's incoming data on the websocket for this channel
    $('#notifications').html('')
    $('#notifications').append "<div class='notification'>#{notification.message}</div>"
    $('#notifications-modal').show();
