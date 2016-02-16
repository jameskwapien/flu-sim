class Group < ActiveRecord::Base
  has_many :users

  def group_filter_by_name
    @group = Group.find_by_name("test")
    @users_group = @group.users
  end

  def group_filter_by_user(user)
    if @group = Group.find_by_mem_one(user.email)
      @user_group = @group.name
    elsif @group = Group.find_by_mem_two(user.email)
      @user_group = @group.name
    elsif @group = Group.find_by_mem_three(user.email)
      @user_group = @group.name
    else
      @user_group = nil
    end
  end
end
