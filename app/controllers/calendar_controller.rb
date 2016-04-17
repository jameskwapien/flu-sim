class CalendarController < ApplicationController

  # GET calendar_index_path
  def index
  	get_session_group
  end
end
