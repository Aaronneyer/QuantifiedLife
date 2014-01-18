class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :authorize
  before_action :check_viewable, only: [:show]
  before_action :check_editable, only: [:edit, :update]

  def index
    @users = User.all
  end

  def show
  end

  def edit
    @attributes = @user.extra_info_attributes.to_json
  end

  def update
    params[:user][:extra_info_attributes] = params[:user][:extra_info_attributes].try(:values)
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

  def check_viewable
    unless current_user.can_view?(@user)
      flash[:notice] = 'You are not permitted to view this user'
      redirect_to root_path
    end
  end

  def check_editable
    unless current_user.can_edit?(@user)
      flash[:notice] = 'You are not permitted to edit this user'
      redirect_to root_path
    end
  end
end
