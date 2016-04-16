class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :group

  def self.belongs_to_course(courseID)
  	Membership.includes(:group).where(:groups => {:course_id => courseID})
  end

  def self.belongs_to_group(groupID)
  	Membership.includes(:group).where(:groups => {:id => groupID})
  end
end
