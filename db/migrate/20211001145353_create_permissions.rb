class CreatePermissions < ActiveRecord::Migration[6.0]
  def change
    create_table :permissions do |t|
      t.string :subject_class, null:false
      t.string :action, null:false
      t.string :description
      t.string :name, null:false

      t.timestamps
    end
  end
end
