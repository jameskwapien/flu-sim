class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :users, through: :comments

  validates :title, presence: true
  validates :content, presence: true
  validates_length_of :title, minimum: 5, maximum: 255
  validates_length_of :content, minimum: 5, maximum: 65535 

  accepts_nested_attributes_for :users
end
