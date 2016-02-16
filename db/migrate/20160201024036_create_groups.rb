class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.string :mem_one
      t.string :mem_two
      t.string :mem_three

      t.timestamps null: false
    end
  end
end
