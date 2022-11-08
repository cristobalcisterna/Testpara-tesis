class AddActiveInvestmentTypeToInvestmentTypes < ActiveRecord::Migration[6.0]
  def change
    add_column :investment_types, :active_investment_type, :integer
  end
end
