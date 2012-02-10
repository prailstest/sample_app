class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  protected

  def admin_only 
    redirect_to root_path, flash: { error: "You don't have permission to do this." } unless current_user.admin?
  end

  def anonymous_only 
    redirect_to root_path if current_user
  end
end
