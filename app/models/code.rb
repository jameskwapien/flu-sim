class Code < ActiveRecord::Base

	def self.are_active
		Code.where(:active => true)
	end

	def self.are_inactive
		Code.where(:active => false)
	end
end
