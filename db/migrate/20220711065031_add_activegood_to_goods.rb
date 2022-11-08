class AddActivegoodToGoods < ActiveRecord::Migration[6.0]
  def change
    add_column :goods, :activegood, :integer
  end
end
