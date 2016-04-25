class Output < ActiveRecord::Base
	belongs_to :input

	def self.belongs_to_input(input_id)
		Output.where(:input_id => input_id)
	end

	def self.belongs_to_group(group_name)
		Output.where(:group_name => group_name)
	end

	def self.num_uniq_days(group_name)
		Output.belongs_to_group(group_name)
	end

	def self.max_day(group_name)
		Output.where(:group_name => group_name).maximum(:day)
	end	

	def self.money_left(group_name)
		Output.belongs_to_group(group_name).last(:money_left)
	end
end
