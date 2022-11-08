class AddActiveOfficeToOffices < ActiveRecord::Migration[6.0]
  def change
    add_column :offices, :active_office, :integer
  end
end
