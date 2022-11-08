class CreateDutyManagers < ActiveRecord::Migration[6.0]
  def change
    create_table :duty_managers do |t|
      t.string :name_duty_manager
      t.string :rut
      t.references :unit, null: false, foreign_key: true

      t.timestamps
    end
  end
end
