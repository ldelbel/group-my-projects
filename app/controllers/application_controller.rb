class ApplicationController < ActionController::Base
  include SessionsHelper
  def home
    redirect_to user_url(current_user) unless current_user.nil?
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
end
