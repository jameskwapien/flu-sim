class AddDefaultToEnrollments < ActiveRecord::Migration
  def change
	change_column :enrollments, :course_id, :integer, limit: 4, null: false
  end
end
