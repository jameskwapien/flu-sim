class Enrollment < ActiveRecord::Base
	belongs_to :user
	belongs_to :course

	validate :enrollment_valid, :on => :create

	def enrollment_valid
		if Enrollment.where(:user_id => self.user_id, :course_id => self.course_id).exists?
			self.errors.add(:course_id, "already has this student enrolled.")
		end
	end	

	def self.with_this_instructor(user_email)
		Enrollment.includes(:course).where(:courses => {:email => user_email})
	end

	def self.in_this_course(course_id, user_id)
		Enrollment.includes(:course).includes(:user).where(:courses => {:id => course_id}).where(:users => {:id => user_id})
	end

	def self.in_course(course_id)
		Enrollment.where(:course_id => course_id)
	end
end
