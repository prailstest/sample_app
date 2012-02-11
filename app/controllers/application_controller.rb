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

  def signed_in_user_only
    unless signed_in?
      store_location
      redirect_to signin_path, notice: "Please sign in to access this page."
    end
  end
end
