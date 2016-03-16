class AddDefaultToTimeStamps < ActiveRecord::Migration
  def change
    change_column :inputs, :created_at, :datetime,  null: true
    change_column :inputs, :updated_at, :datetime,  null: true
    change_column :outputs, :created_at, :datetime,  null: true
    change_column :outputs, :updated_at, :datetime,  null: true
  end
end
