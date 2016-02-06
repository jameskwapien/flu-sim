class RemoveMembersFromGroups < ActiveRecord::Migration
  def change
    remove_column :groups, :mem_one, :string
    remove_column :groups, :mem_two, :string
    remove_column :groups, :mem_three, :string
  end
end
