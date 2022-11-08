class RemoveRepairableFromConditionGood < ActiveRecord::Migration[6.0]
  def change
    remove_column :condition_goods, :repairable, :integer
  end
end
