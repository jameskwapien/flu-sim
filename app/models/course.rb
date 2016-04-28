class Course < ActiveRecord::Base
	has_many :enrollments
	has_many :users, through: :enrollments
	validates_length_of :name, minimum: 5, maximum: 30, allow_blank: false

	def name_crn
		"#{self.name}, #{self.crn}"
	end

	def self.by_teacher(instructor_email)
		Course.where(:email => instructor_email)
	end
end
