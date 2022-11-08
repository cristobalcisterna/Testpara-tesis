class CreateOffices < ActiveRecord::Migration[6.0]
  def change
    create_table :offices do |t|
      t.string :name_office
      t.string :identification_number_office
      t.string :location
      t.text :office_description
      t.integer :hours_available
      t.integer :square_meter
      t.string :campus_identification
      t.references :duty_manager, null: false, foreign_key: true
      t.references :building, null: false, foreign_key: true

      t.timestamps
    end
  end
end
