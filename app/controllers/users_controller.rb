class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :authenticate_user!
  before_action :check_correct_user, except: [:index]

  def index
    @users = User.all.desc(:date)
  end

  def show
  end

  def edit
    @attributes = @user.extra_info_attributes.to_json
  end

  def update
    params[:user][:extra_info_attributes] = params[:user][:extra_info_attributes].values
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        @attributes = @user.extra_info_attributes.to_json
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(extra_info_attributes: [:key_name, :type, :value])
    end

    def check_correct_user
      redirect_to root_path unless @user == current_user || current_user.admin?
    end
end
