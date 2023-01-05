class ApplicationController < ActionController::Base
  before_action :authorized
  # before_action :isAdminUser
  helper_method :current_user
  helper_method :is_login?
  # helper_method :is_admin?
  def current_user
    User.find_by(id: session[:user_id])
  end
  def is_login?
    !current_user.nil?
  end

  # def is_admin?
  #   User.find_by(id: session[:user_id]).is_admin == true
  # end

  def authorized
    redirect_to '/login' unless is_login?
  end

  # def isAdminUser
  #   redirect_to '/posts' unless is_admin?
  # end
end
