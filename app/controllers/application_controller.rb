class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  helper_method :get_session_course
  
  def after_sign_in_path_for(user)
    welcome_index_path
  end
 
  def after_sign_out_path_for(user)
    root_path
  end

  def get_session_course
    @session_course = Course.find(session[:course_id])
  end
end
