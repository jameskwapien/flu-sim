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
    if self.instructor?
      unless self.invite_code == "999"
        self.errors.add(:invite_code, "invalid for instructors.")
      end
    else
      unless self.invite_code == "000"
        self.errors.add(:invite_code, "invalid for students.")
      end
    end
  end  

  # Self queries
  def self.match(userID)
    User.where(:id => userID)
  end

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

  def self.in_this_group(groupID)
    User.includes(:memberships).where(:memberships => {:group_id => goupID})
  end

  # COURSE queries

  def self.in_a_course(courseID)
    User.includes(:enrollments).where(:enrollments => {:course_id => courseID})
  end

  def self.in_a_course_group(courseID)
    User.includes(:memberships).includes(:groups).where(:groups => {:course_id => courseID})
  end

  def self.not_in_a_course_group(courseID)
    User.includes(:memberships).includes(:groups).where.not(:groups => {:course_id => courseID})
  end
end
