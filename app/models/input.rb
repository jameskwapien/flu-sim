class Input < ActiveRecord::Base
	has_many :outputs
	validate :pay_for_vaccines_and_ads, :on => :create, :on => :update

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
    	end
    end
end
