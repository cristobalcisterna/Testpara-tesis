class AddLinkToConditionGood < ActiveRecord::Migration[6.0]
  def change
    add_column :condition_goods, :link, :text
  end
end
