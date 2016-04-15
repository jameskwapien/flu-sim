class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :memberships
  has_many :groups, through: :memberships

  has_many :comments
  has_many :posts
  attr_accessor :invite_code
  validate :invite_code_valid, :on => :create

  def invite_code_valid
    unless self.invite_code == "000"
      self.errors.add(:invite_code, "invalid")
    end
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

  def self.not_in_any_group
    User.includes(:memberships).where(:memberships => {:user_id => nil})
  end  

  def self.in_a_group
    User.includes(:memberships).where(:memberships => {:user_id => !nil})
  end

  def membership?(group)
    memberships.find_by(group: group).present?
  end

end
