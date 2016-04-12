class Output < ActiveRecord::Base
	belongs_to :input

	def self.belongs_to_input(inputID)
		Output.where(:input_id => inputID)
	end
end
