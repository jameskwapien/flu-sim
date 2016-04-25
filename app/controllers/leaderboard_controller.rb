class LeaderboardController < ApplicationController

	# GET request
	def index
	end

	# GET request
	def show
		if params[:course_id].present?
	    	@course_id = Course.find(params[:course_id])
	    else
	    	redirect_to leaderboard_index_path
	    end
	end
end
