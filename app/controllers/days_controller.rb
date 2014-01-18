class DaysController < ApplicationController
  before_action :set_day, only: [:show, :edit, :update, :fetch_moves]
  before_action :authorize
  before_action :set_and_check_viewer, only: [:index]
  before_action :check_viewable, only: [:show]
  before_action :check_editable, only: [:edit, :update, :fetch_moves]

  # GET /days
  # GET /days.json
  def index
    @days = Day.all.order('date DESC')
  end

  # GET /days/1
  # GET /days/1.json
  def show
    @moves_segments = @day.moves_storyline['segments'] || []
    @moves_summary = @day.moves_summary['summary'] || []
  end

  # GET /days/new
  def new
    @day = Day.new(user: current_user, start_location: Day.last.try(:end_location))
    @attributes = @day.extra_info_attributes.to_json
  end

  # GET /days/1/edit
  def edit
    @attributes = @day.extra_info_attributes.to_json
  end

  # POST /days
  # POST /days.json
  def create
    params[:day][:extra_info_attributes] = params[:day][:extra_info_attributes].values
    @day = Day.new(day_params)
    @day.user = current_user

    respond_to do |format|
      if @day.save
        format.html { redirect_to @day, notice: 'Day was successfully created.' }
        format.json { render action: 'show', status: :created, location: @day }
      else
        @attributes = @day.extra_info_attributes.to_json
        format.html { render action: 'new' }
        format.json { render json: @day.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /days/1
  # PATCH/PUT /days/1.json
  def update
    params[:day][:extra_info_attributes] = params[:day][:extra_info_attributes].values
    respond_to do |format|
      if @day.update(day_params)
        format.html { redirect_to @day, notice: 'Day was successfully updated.' }
        format.json { head :no_content }
      else
        @attributes = @day.extra_info_attributes.to_json
        format.html { render action: 'edit' }
        format.json { render json: @day.errors, status: :unprocessable_entity }
      end
    end
  end

  def fetch_moves
    @day.fetch_moves
    redirect_to @day
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_day
    @day = Day.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def day_params
    params.require(:day).permit(:date, :headline, :summary, :impact, :start_location, :end_location,
                                extra_info_attributes: [:key_name, :type, :value])
  end

  def check_viewable
    unless current_user.can_view?(@day.user)
      redirect_to root_path
    end
  end

  def check_editable
    unless current_user.can_edit?(@day.user)
      redirect_to root_path
    end
  end
end
