class CreateGoods < ActiveRecord::Migration[6.0]
  def change
    create_table :goods do |t|
      t.string :namegood
      t.text :good_description
      t.string :identification_number_usach
      t.string :identification_number_good
      t.string :serie_number
      t.string :internal_number
      t.string :trademark
      t.date :date_purchase
      t.date :date_release
      t.string :location_good
      t.integer :amount
      t.string :financial_source
      t.string :investment_type
      t.references :duty_manager, null: false, foreign_key: true
      t.references :office, null: false, foreign_key: true

      t.timestamps
    end
  end
end
