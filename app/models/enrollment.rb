class Enrollment < ActiveRecord::Base
	belongs_to :user
	belongs_to :course

	validate :enrollment_valid, :on => :create

	def enrollment_valid
		if Enrollment.where(:user_id => self.user_id, :course_id => self.course_id).exists?
			self.errors.add(:course_id, "already has this student enrolled.")
		end
	end	

	def self.with_this_instructor(userEmail)
		Enrollment.includes(:course).where(:courses => {:email => userEmail})
	end

	def self.in_this_course(courseID, userID)
		Enrollment.includes(:course).includes(:user).where(:courses => {:id => courseID}).where(:users => {:id => userID})
	end
end
