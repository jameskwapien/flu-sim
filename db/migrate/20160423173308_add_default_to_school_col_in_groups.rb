class AddDefaultToSchoolColInGroups < ActiveRecord::Migration
  def change
	change_column :inputs, :school_off, :integer, :default => 0
  end
end
