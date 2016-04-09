class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def after_sign_in_path_for(user)
    welcome_index_path
  end
 
  def after_sign_out_path_for(user)
    root_path
  end
  
  def owned(post)
    current_user.id = post.user_id
  end 
	
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to posts_path, :alert => exception.message    
  end

end
