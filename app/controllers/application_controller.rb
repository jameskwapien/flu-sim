class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  helper_method :get_session_course, :get_session_group, :get_session_input, :whatAmI, :get_output_count

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

  def get_session_course
    @session_course = Course.find(session[:course_id])
  end

  def get_session_group
    @session_group = Group.find(session[:group_id])
  end

  def get_session_input
    @session_input = Input.find(session[:input_id])
  end

  def get_output_count(output)
    count = 0
    @final_count = 0
    output.input_id
    test_input_id = -1
    Output.belongs_to_group(output.group_name).each do |o|
      if test_input_id != o.input_id
        test_input_id = o.input_id
        count += 1
      end
      if o.input_id == @output.input_id
        @final_count = count
      end
    end
  end

end
