class CreateInternalPositions < ActiveRecord::Migration[6.0]
  def change
    create_table :internal_positions do |t|
      t.string :name, null:false
      t.string :description
      t.boolean :is_real

      t.timestamps
    end
  end
end
