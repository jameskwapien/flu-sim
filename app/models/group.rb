class Group < ActiveRecord::Base
  has_many :memberships
  has_many :users, through: :memberships

  def self.belongs_to_course(courseID)
  	Group.where(:course_id => courseID)
  end
end
