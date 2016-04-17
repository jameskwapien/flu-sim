class AddDefaultToDaysColumn < ActiveRecord::Migration
  def change
	change_column :courses, :days, :integer, default: 0
  end
end
