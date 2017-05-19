# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

App.activity = App.cable.subscriptions.create "NotificationChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (notification) ->
    # Called when there's incoming data on the websocket for this channel
    $('#notifications').html('')
    $('#notifications').append "<div class='notification'>#{notification.message}</div>"
    $('#notifications-modal').css('display', 'block');
