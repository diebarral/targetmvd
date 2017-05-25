class MessagesController < ApplicationController

  # POST /messages
  def create
    respond_to do |format|
      if @message = Message.create({ text: params[:text], destinatary: params[:destinatary], match_id: params[:match_id], read: false })
        format.json { head :no_content }

      else
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end
end
