class AddColumnToOutputs < ActiveRecord::Migration
  def change
    add_column :outputs, :input_id, :integer
  end
end
