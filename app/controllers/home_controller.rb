class HomeController < ApplicationController

  before_action :authenticate_user!, except: [:welcome, :load_sign_up, :load_sign_in]

  def index
    all_matches_for_current_user = Match.for_user(current_user.id)
    @matches = []
    @has_unread_messages
    @global_unread_messages_count = 0

    all_matches_for_current_user.each do |match|
      destinatary = match.get_destinatary(current_user.id)
      unread = Message.of_conversation(match.id).unread_for_user(current_user.id).count
      if unread > 0
        @has_unread_messages = true
        @global_unread_messages_count += unread
      end
      @matches.push({ id: match.id, user_id: destinatary.id, user_name: destinatary.name, topic: match.topic.name, unread: unread })
    end
    @target_count = current_user.targets.count
  end

  def welcome

  end

  def load_sign_in
    respond_to do |format|
      format.js
    end
  end

  def load_sign_up
  	respond_to do |format|
      format.js
    end
  end
end
