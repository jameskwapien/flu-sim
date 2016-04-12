class AddColumnToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :instructor, :string, limit: 255
    add_column :courses, :email, :string, limit: 255
  end
end
