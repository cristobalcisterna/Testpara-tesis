class AddEmailToDutyManager < ActiveRecord::Migration[6.0]
  def change
    add_column :duty_managers, :email, :string
  end
end
