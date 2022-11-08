class AddGoodToConditionGood < ActiveRecord::Migration[6.0]
  def change
    add_reference :condition_goods, :good, null: false, foreign_key: true
  end
end
