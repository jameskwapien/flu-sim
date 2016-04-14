class Output < ActiveRecord::Base
	belongs_to :input

	def self.belongs_to_input(inputID)
		Output.where(:input_id => inputID)
	end

	def self.num_uniq_days(groupName)
		Output.where(:group_name => groupName)
	end

	def self.max_day(groupName)
		Output.where(:group_name => groupName).maximum(:day)
	end	
end
