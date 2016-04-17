class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post


  validates :content, presence: true

  accepts_nested_attributes_for :post
  
end
