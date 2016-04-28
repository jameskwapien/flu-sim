class CreateCodes < ActiveRecord::Migration
  def change
    create_table :codes do |t|
      t.boolean :active
      t.integer :student
      t.integer :instructor
      
      t.timestamps null: false
    end
  end
end
