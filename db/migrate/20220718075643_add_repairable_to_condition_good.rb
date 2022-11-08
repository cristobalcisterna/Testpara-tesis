class AddRepairableToConditionGood < ActiveRecord::Migration[6.0]
  def change
    add_column :condition_goods, :repairable, :string
  end
end
