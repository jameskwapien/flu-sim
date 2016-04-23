class Group < ActiveRecord::Base
  has_many :memberships
  has_many :users, through: :memberships
  validates :name, format: { with: /\A[a-zA-Z0-9]+\Z/ }

  def self.belongs_to_course(courseID)
  	Group.where(:course_id => courseID)
  end
end
