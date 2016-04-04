class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name, limit: 30
      t.integer :crn		
      t.timestamps null: false
    end
  end
end
