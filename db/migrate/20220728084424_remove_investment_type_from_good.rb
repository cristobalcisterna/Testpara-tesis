class RemoveInvestmentTypeFromGood < ActiveRecord::Migration[6.0]
  def change
    remove_column :goods, :investment_type, :string
  end
end
