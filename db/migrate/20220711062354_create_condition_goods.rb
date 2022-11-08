class CreateConditionGoods < ActiveRecord::Migration[6.0]
  def change
    create_table :condition_goods do |t|
      t.date :lost_date
      t.text :loss_detail
      t.date :destruction_date
      t.text :destruction_detail
      t.integer :repairable
      t.date :request_date
      t.integer :request_status
      t.text :income_reason
      t.date :date_entry
      t.references :goods, null: false, foreign_key: true
      t.references :condition, null: false, foreign_key: true

      t.timestamps
    end
  end
end
