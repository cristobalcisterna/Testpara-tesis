class CreateInvestmentTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :investment_types do |t|
      t.string :name_investment_type
      t.text :detail

      t.timestamps
    end
  end
end
