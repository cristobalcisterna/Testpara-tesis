class AddActiveUnitToUnits < ActiveRecord::Migration[6.0]
  def change
    add_column :units, :active_unit, :integer
  end
end
