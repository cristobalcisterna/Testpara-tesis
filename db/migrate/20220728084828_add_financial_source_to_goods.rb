class AddFinancialSourceToGoods < ActiveRecord::Migration[6.0]
  def change
    add_reference :goods, :financial_source, null: false, foreign_key: true
  end
end
