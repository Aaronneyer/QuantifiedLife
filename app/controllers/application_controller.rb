class ApplicationController < ActionController::Base
  include Clearance::Controller
  protect_from_forgery

  private

  def set_and_check_viewer
    if params[:user_id]
      @user = User.find(params[:user_id])
    else
      @user = current_user
    end

    unless current_user.can_view?(@user)
      flash[:warning] = 'You do not have permission to view this page'
      redirect_to root_path
    end
  end
end
