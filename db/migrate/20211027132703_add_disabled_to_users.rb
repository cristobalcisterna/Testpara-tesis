class AddDisabledToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :disabled, :string
    add_column :users, :active_profile, :integer
  end
end
