class Input < ActiveRecord::Base
	has_many :outputs

	def self.belongs_to_group(groupName)
		Input.where(:group_name => groupName)
	end
end
