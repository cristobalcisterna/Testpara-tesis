class AddActiveFinancialSourceToFinancialSources < ActiveRecord::Migration[6.0]
  def change
    add_column :financial_sources, :active_financial_source, :integer
  end
end
