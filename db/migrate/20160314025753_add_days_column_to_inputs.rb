class AddDaysColumnToInputs < ActiveRecord::Migration
  def change
    add_column :inputs, :days, :integer, after: :school_off
  end
end
