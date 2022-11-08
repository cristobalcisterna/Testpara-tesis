class AddActiveDutyManagerToDutyManagers < ActiveRecord::Migration[6.0]
  def change
    add_column :duty_managers, :active_duty_manager, :integer
  end
end
