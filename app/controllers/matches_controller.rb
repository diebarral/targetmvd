class MatchesController < ApplicationController

  before_action :authenticate_user!

  def get_messages
    this_match = Match.find(params[:id])
    @messages = this_match.messages.last(8)
    @username = this_match.get_destinatary(current_user.id).name
    @topic = this_match.topic
    update_messages(params[:id])

    render json: { form: (render_to_string partial: 'conversation', locals: { messages: @messages, with: @username, about: @topic } ) }
  end

  def mark_as_read
    update_messages(params[:id])
  end

  private

  def update_messages(id)
    Message.where(match_id: params[:id], destinatary: current_user.id, read: false).update_all(read: true)
  end
end
