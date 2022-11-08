class CreateFinancialSources < ActiveRecord::Migration[6.0]
  def change
    create_table :financial_sources do |t|
      t.string :name_financial_source
      t.text :detail

      t.timestamps
    end
  end
end
