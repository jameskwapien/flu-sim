class AddDaysColumnToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :days, :integer, default: 0
  end
end
