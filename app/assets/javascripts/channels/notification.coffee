App.notification = App.cable.subscriptions.create "NotificationChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (notification) ->
    if notification.code == 'notification'
      $('#notifications').html("<div class='notification'>#{ notification.message.html_elem }</div>")
      $('#notifications-modal').show()
      $('#matches-table').append($("<tr>").addClass("matches-table-row").data('match-id', notification.message.match_id).data('user-id', notification.message.user_id).append($("<td>").html(notification.message.username + ' about ' + notification.message.topic)));

    else if notification.code == 'message'
      match_id = parseInt($('#match').val())

      if match_id == notification.message.match_id
        $('#conversation-body').append(notification.message.html_element)
        $("#conversation-container").animate({ scrollTop: $("#conversation-container")[0].scrollHeight}, 1000);
        $.post({ url: '/matches/mark_as_read', data: { id: notification.message.match_id }});
      else
        $('#update-unread-messages-counts').change();




