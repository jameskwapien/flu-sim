class Input < ActiveRecord::Base
	has_many :outputs

	def self.belongs_to_group(groupID)
		Input.where(:group_name => groupID)
	end
end
