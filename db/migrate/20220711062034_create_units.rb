class CreateUnits < ActiveRecord::Migration[6.0]
  def change
    create_table :units do |t|
      t.string :name_unit
      t.string :description_unit
      t.string :identification_number_unit

      t.timestamps
    end
  end
end
