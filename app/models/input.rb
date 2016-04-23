class Input < ActiveRecord::Base
	has_many :outputs
	validate :pay_for_vaccines_and_ads, :add_previous_vaccines

	def self.belongs_to_group(groupName)
		Input.where(:group_name => groupName)
	end

	def pay_for_vaccines_and_ads
		if self.vaccines * 13 > self.money_left
      		self.errors.add(:vaccines, "You can't afford that many vaccines!")
    	elsif self.ads > self.money_left
    		self.errors.add(:ads, "You can't afford that much advertising!")
    	elsif ((self.vaccines * 13) + self.ads) > self.money_left
			self.errors.add(:money_left, "You can't afford that many vaccines and advertising!")
    	else
    		self.money_left = self.money_left - ((self.vaccines * 13) + (self.ads))
    	end
    end

    def add_previous_vaccines
    	count = Input.belongs_to_group(self.group_name).count
		if count > 0
			last_input_id = Input.belongs_to_group(self.group_name).last.id
			leftover_vaccs = 0
			Output.belongs_to_input(last_input_id).each do |output|
				leftover_vaccs = leftover_vaccs + output.vaccs_left
			end
			self.vaccines = self.vaccines + leftover_vaccs
		end
	end
end
