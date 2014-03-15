class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy]
  before_action :authorize
  before_action :set_and_check_viewer, only: [:index]
  before_action :check_viewable, only: [:show]
  before_action :check_editable, only: [:edit, :update]

  # GET /photos
  # GET /photos.json
  def index
    @photos = Photo.where(user_id: @user.id).order('datetime DESC')
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
    if params.has_key?(:partial)
      render layout: false
    end
  end

  def image
    s3 = AWS::S3.new
    blob = s3.buckets['quantifiedlife'].objects[params[:id]].read
    # TODO: This might make things slow. Keep an eye on it
    image = Magick::Image.from_blob(blob).first
    if params[:resize]
      image.resize_to_fit!(params[:resize].to_i)
    end
    send_data(image.to_blob, type: 'image/jpg', disposition: 'inline')
  end

  # GET /photos/1/edit
  def edit
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update
    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to @photo, notice: 'photo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    respond_to do |format|
      format.html { redirect_to photos_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_photo
    @photo = Photo.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def photo_params
    params.require(:photo).permit(:caption)
  end

  def check_viewable
    unless current_user.can_view?(@photo.user)
      redirect_to root_path
    end
  end

  def check_editable
    unless current_user.can_edit?(@photo.user)
      redirect_to root_path
    end
  end
end
