class Group < ActiveRecord::Base
  has_many :members, class_name: "User", inverse_of: :user

end
