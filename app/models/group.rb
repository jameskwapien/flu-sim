class Group < ActiveRecord::Base
  has_many :memberships
  has_many :users, through: :memberships
  validates :name, format: { with: /\A[a-zA-Z0-9]+\Z/ }
  validates_length_of :name, minimum: 5, maximum: 30
  
  def self.belongs_to_course(course_id)
  	Group.where(:course_id => course_id)
  end
end
