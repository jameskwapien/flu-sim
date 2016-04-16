class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  helper_method :whatAmI

  def after_sign_in_path_for(user)
    root_path
  end
 
  def after_sign_out_path_for(user)
    unauthenticated_root_path
  end
  
  def owned(post)
    current_user.id = post.user_id
  end

  def whatAmI
    if current_user.admin? 
      @whatAmI = ["Admin", "partials/acontrol"]
    elsif current_user.instructor? 
      @whatAmI = ["Instructor", "partials/icontrol"]
    elsif (!current_user.instructor? && !current_user.admin?)
      @whatAmI = ["Student", "partials/scontrol"]
    end 
  end 
	
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to posts_path, :notice => exception.message    
  end

end
