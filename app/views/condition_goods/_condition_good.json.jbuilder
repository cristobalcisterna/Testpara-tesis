json.extract! condition_good, :id, :lost_date, :loss_detail, :link, :activeconditiongood, :destruction_date, :destruction_detail, :repairable, :request_date, :request_status, :income_reason, :date_entry, :good_id, :condition_id, :created_at, :updated_at
json.url condition_good_url(condition_good, format: :json)

json.good do
    json.namegood condition_good.good.namegood
    json.activegood condition_good.good.activegood
    json.office_id condition_good.good.office_id
    json.name_office condition_good.good.office.name_office
    json.building_id condition_good.good.office.building_id
    json.name_building condition_good.good.office.building.name_building 
    json.duty_manager_id condition_good.good.duty_manager_id
    json.name_duty_manager condition_good.good.duty_manager.name_duty_manager
    json.unit_id condition_good.good.duty_manager.unit_id
    json.name_unit condition_good.good.duty_manager.unit.name_unit
end 

json.condition do
    json.state_name condition_good.condition.state_name
end 

