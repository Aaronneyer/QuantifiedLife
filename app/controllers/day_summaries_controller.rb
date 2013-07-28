class DaySummariesController < ApplicationController
  before_action :set_day_summary, only: [:show, :edit, :update, :destroy]

  # GET /day_summaries
  # GET /day_summaries.json
  def index
    @day_summaries = DaySummary.all
  end

  # GET /day_summaries/1
  # GET /day_summaries/1.json
  def show
  end

  # GET /day_summaries/new
  def new
    @day_summary = DaySummary.new
  end

  # GET /day_summaries/1/edit
  def edit
  end

  # POST /day_summaries
  # POST /day_summaries.json
  def create
    @day_summary = DaySummary.new(day_summary_params)

    respond_to do |format|
      if @day_summary.save
        format.html { redirect_to @day_summary, notice: 'Day summary was successfully created.' }
        format.json { render action: 'show', status: :created, location: @day_summary }
      else
        format.html { render action: 'new' }
        format.json { render json: @day_summary.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /day_summaries/1
  # PATCH/PUT /day_summaries/1.json
  def update
    respond_to do |format|
      if @day_summary.update(day_summary_params)
        format.html { redirect_to @day_summary, notice: 'Day summary was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @day_summary.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /day_summaries/1
  # DELETE /day_summaries/1.json
  def destroy
    @day_summary.destroy
    respond_to do |format|
      format.html { redirect_to day_summaries_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_day_summary
      @day_summary = DaySummary.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def day_summary_params
      params.require(:day_summary).permit(:day, :summary, :blog_post_id, :metadata)
    end
end
