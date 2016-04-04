class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # USER has many GROUPS through MEMBERSHIPS
  has_many :memberships
  has_many :groups, through: :memberships
  # USER has many POSTS and many COMMENTS
  has_many :posts
  has_many :comments
  # USER has many COURSES through REGISTRATIONS
  has_many :enrollments
  has_many :courses, through: :enrollments
  # For invite code validation
  attr_accessor :invite_code
  validate :invite_code_valid, :on => :create

  # Invite code validation
  def invite_code_valid
    unless self.invite_code == "000"
      self.errors.add(:invite_code, "invalid")
    end
  end  

  # Self queries
  def self.admin
    User.where(admin: true)
  end

  def self.instructor
    User.where(instructor: true)
  end

  def self.student
    User.where(instructor: false, admin: false)
  end

  # GROUP queries
  def self.not_in_any_group
    User.includes(:memberships).where(:memberships => {:user_id => nil})
  end  

  def self.in_a_group
    User.includes(:memberships).where(:memberships => {:user_id => !nil})
  end

  def membership?(group)
    memberships.find_by(group: group).present?
  end

  # COURSE queries

end
