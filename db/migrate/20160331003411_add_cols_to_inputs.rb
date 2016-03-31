class AddColsToInputs < ActiveRecord::Migration
  def change
    add_column :inputs, :seed, :integer
    add_column :inputs, :ads, :integer
    add_column :inputs, :money_left, :integer   
  end
end
