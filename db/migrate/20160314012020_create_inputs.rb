class CreateInputs < ActiveRecord::Migration
  def change
    create_table :inputs do |t|
      t.string :group_name, limit: 30
      t.integer :vaccines
      t.integer :school_off
      t.timestamps null: false
    end
  end
end
