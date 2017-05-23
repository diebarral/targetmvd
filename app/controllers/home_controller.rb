class HomeController < ApplicationController

  before_action :authenticate_user!, except: [:welcome, :load_sign_up, :load_sign_in]

  def index
    @matches = Match.for_user(current_user.id)
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
