class CalendarController < ApplicationController

  # GET calendar_index_path
  def index
  	unless current_user.instructor? || current_user.admin?
  		get_session_group
  	end
  end
end
