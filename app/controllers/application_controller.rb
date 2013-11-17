class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def set_and_check_viewer
    if params[:user_id]
      @user = User.find(params[:user_id])
    else
      @user = current_user
    end

    unless current_user.can_view?(@user)
      redirect_to root_path
    end
  end
end
