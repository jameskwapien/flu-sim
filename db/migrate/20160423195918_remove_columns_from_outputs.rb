class RemoveColumnsFromOutputs < ActiveRecord::Migration
  def change
	remove_column :outputs, :money_left
	remove_column :outputs, :money_spent_vaccines
	remove_column :outputs, :money_spent_ads
  end
end
