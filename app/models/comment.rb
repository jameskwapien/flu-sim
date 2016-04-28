class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  validates :user_id, :post_id, :content, presence: true
  validates_length_of :content, minimum: 5, maximum: 65535

  accepts_nested_attributes_for :post
end