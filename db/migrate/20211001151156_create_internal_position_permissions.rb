class CreateInternalPositionPermissions < ActiveRecord::Migration[6.0]
  def change
    create_table :internal_position_permissions do |t|
      t.references :internal_position, null: false, foreign_key: true
      t.references :permission, null: false, foreign_key: true
      t.integer :unit_id

      t.timestamps
    end
  end
end
