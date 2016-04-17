class Group < ActiveRecord::Base
  has_many :memberships
  has_many :users, through: :memberships

  def self.belongs_to_course(course_id)
  	Group.where(:course_id => course_id)
  end
end
