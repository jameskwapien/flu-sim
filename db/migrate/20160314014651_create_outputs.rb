class CreateOutputs < ActiveRecord::Migration
  def change
    create_table :outputs do |t|
      t.string :group_name, limit: 30
      t.decimal :money_left, precision: 64, scale: 12
      t.decimal :money_spent_vaccines, precision: 64, scale: 12
      t.decimal :money_spent_ads, precision: 64, scale: 12
      t.integer :vaccs_left
      t.integer :population
      t.integer :sick
      t.integer :immune
      t.integer :pop_age0
      t.integer :sick_age0
      t.integer :pop_age1
      t.integer :sick_age1
      t.integer :pop_age2
      t.integer :sick_age2
      t.integer :day
      t.integer :cityID

      t.timestamps null: false
    end
  end
end
