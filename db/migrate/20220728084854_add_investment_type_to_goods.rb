class AddInvestmentTypeToGoods < ActiveRecord::Migration[6.0]
  def change
    add_reference :goods, :investment_type, null: false, foreign_key: true
  end
end
