class RemoveGoodsFromConditionGood < ActiveRecord::Migration[6.0]
  def change
    remove_reference :condition_goods, :goods, null: false, foreign_key: true
  end
end
