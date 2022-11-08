class RemoveFinancialSourceFromGood < ActiveRecord::Migration[6.0]
  def change
    remove_column :goods, :financial_source, :string
  end
end
