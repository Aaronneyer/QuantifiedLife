class DaysController < ApplicationController
  before_action :set_day, only: [:show, :edit, :update]
  before_action :authenticate_user!

  # GET /days
  # GET /days.json
  def index
    @days = Day.all.desc(:date)
  end

  # GET /days/1
  # GET /days/1.json
  def show
  end

  # GET /days/new
  def new
    @day = Day.new
    @day.set_defaults
    @attributes = @day.metadata_attributes.to_json
  end

  # GET /days/1/edit
  def edit
    @attributes = @day.metadata_attributes.to_json
  end

  # POST /days
  # POST /days.json
  def create
    params[:day][:metadata_attributes] = params[:day][:metadata_attributes].values
    @day = Day.new(day_params)

    respond_to do |format|
      if @day.save
        format.html { redirect_to @day, notice: 'Day was successfully created.' }
        format.json { render action: 'show', status: :created, location: @day }
      else
        @attributes = @day.metadata_attributes.to_json
        format.html { render action: 'new' }
        format.json { render json: @day.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /days/1
  # PATCH/PUT /days/1.json
  def update
    params[:day][:metadata_attributes] = params[:day][:metadata_attributes].values
    respond_to do |format|
      if @day.update(day_params)
        format.html { redirect_to @day, notice: 'Day was successfully updated.' }
        format.json { head :no_content }
      else
        @attributes = @day.metadata_attributes.to_json
        format.html { render action: 'edit' }
        format.json { render json: @day.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_day
      @day = Day.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def day_params
      params.require(:day).permit(:date, :summary, :impact, :post_id, metadata_attributes: [:key_name, :type, :value])
    end
end
