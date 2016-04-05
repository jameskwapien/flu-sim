class Enrollment < ActiveRecord::Base
	belongs_to :user
	belongs_to :course

	#validate :enrollment_valid, :on => :create

	def enrollment_valid
		if Enrollment.where(:user_id => self.user_id, :course_id => self.course_id)
			self.errors.add(:course_id, "already has this student enrolled.")
		end
	end	
end
