class AddActiveconditiongoodToConditionGood < ActiveRecord::Migration[6.0]
  def change
    add_column :condition_goods, :activeconditiongood, :integer
  end
end
