class MatchesController < ApplicationController

  before_action :authenticate_user!

  def get_messages
    this_match = Match.find(params[:id])
    @messages = this_match.messages.last(8)
    @username = this_match.user_a_id != current_user.id ? this_match.user_a.name : this_match.user_b.name
    @topic = this_match.topic
    render json: { form: (render_to_string partial: 'conversation', locals: { messages: @messages, with: @username, about: @topic } ) }
  end
end
