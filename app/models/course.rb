class Course < ActiveRecord::Base
	has_many :enrollments
	has_many :users, through: :enrollments

	def name_crn
		"#{self.name}, #{self.crn}"
	end

	def self.by_teacher(instructor_email)
		Course.where(:email => instructor_email)
	end
end
