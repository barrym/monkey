class UserSettingsController < ApplicationController

  before_filter :check_signed_in

  def edit
    @user_setting = current_user.user_setting || UserSetting.new
  end

  def update
    current_user.user_setting = UserSetting.new unless current_user.user_setting
    current_user.user_setting.update_attributes(params[:user_setting])
    redirect_to root_path
  end

  private

  def check_signed_in
    unless signed_in?
      flash[:error] = "You are not logged in"
      redirect_to root_path
    end
  end

end
