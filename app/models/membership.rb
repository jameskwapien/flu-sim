class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :group

  def self.belongs_to_course(course_id)
  	Membership.includes(:group).where(:groups => {:course_id => course_id})
  end

  def self.belongs_to_group(group_id)
  	Membership.includes(:group).where(:groups => {:id => group_id})
  end

  def self.belongs_to_user(user_id)
  	Membership.includes(:user).where(:users => {:id => user_id})
  end
end
