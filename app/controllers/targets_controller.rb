class TargetsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_target, only: [:show, :edit]
  before_action :set_topics, only: [:edit, :load_create_form]

  # GET /targets
  # GET /targets.json
  def index
    @targets = current_user.targets
  end

  # GET /targets/1
  # GET /targets/1.json
  def show
  end

  # GET /targets/new
  def new
    @target = Target.new
  end

  def load_create_form
    @target = Target.new

    render json: { form: (render_to_string partial: 'create_form') }
  end

  def list
    targets = current_user.targets
    render :json => targets
  end

  # GET /targets/1/edit
  def edit
    render json: { form: (render_to_string partial: 'edit_form', target: @target )}
  end

  # POST /targets
  # POST /targets.json
  def create

    respond_to do |format|
      if @target = current_user.targets.create(target_params)
        format.html { redirect_to index_home_path, notice: 'Target was successfully created.' }
        format.json { render :show, status: :created, location: @target }
      else
        format.html { render :new }
        format.json { render json: @target.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /targets/1
  # PATCH/PUT /targets/1.json
  def update
    @target = current_user.targets.find(params[:target][:id])

    respond_to do |format|
      if @target.update(target_params)
        format.html { redirect_to index_home_path, notice: 'Target was successfully updated.' }
        format.json { render :show, status: :ok, location: @target }
      else
        format.html { render :edit }
        format.json { render json: @target.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /targets/1
  # DELETE /targets/1.json
  def destroy
    @target = current_user.targets.find(params[:id])
    @target.destroy

    respond_to do |format|
      format.html { redirect_to index_home_path, notice: 'Target was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_target
      @target = Target.find(params[:id])
    end

    def set_topics
      @topics = Topic.all
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def target_params
      params.fetch(:target, {}).permit(:radius, :title, :latitude, :longitude, :topic_id)
    end
end
