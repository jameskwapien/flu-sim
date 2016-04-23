class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  validates :user_id, :post_id, :content, presence: true

  accepts_nested_attributes_for :post
end