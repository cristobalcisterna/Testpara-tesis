json.extract! building, :id, :name_building, :identification_number_building, 
:location_building, :duty_manager_id, :unit_id, 
:created_at, :updated_at
json.url building_url(building, format: :json)

json.duty_manager do
    json.name_duty_manager building.duty_manager.name_duty_manager
    json.active_duty_manager building.duty_manager.active_duty_manager
end


json.unit do
    json.name_unit building.unit.name_unit
    json.active_unit building.unit.active_unit
end