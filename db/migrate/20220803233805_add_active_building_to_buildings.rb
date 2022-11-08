class AddActiveBuildingToBuildings < ActiveRecord::Migration[6.0]
  def change
    add_column :buildings, :active_building, :integer
  end
end
