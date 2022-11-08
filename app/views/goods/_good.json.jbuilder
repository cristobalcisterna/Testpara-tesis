json.extract! good, :id, :namegood, :good_description, :identification_number_usach, 
            :identification_number_good, :serie_number, :internal_number,
            :trademark, :date_purchase, :date_release, :location_good, :activegood, 
            :amount, :financial_source_id, :investment_type_id, 
            :duty_manager_id, :office_id, :created_at, :updated_at 
            
json.url good_url(good, format: :json)
 
json.office do
    json.name_office good.office.name_office
    json.active_office good.office.active_office
    json.building_id good.office.building_id
    json.name_building good.office.building.name_building  
end

json.duty_manager do
    json.name_duty_manager good.duty_manager.name_duty_manager
    json.active_duty_manager good.duty_manager.active_duty_manager
    json.unit_id good.duty_manager.unit_id
    json.name_unit good.duty_manager.unit.name_unit
end

json.investment_type do
    json.name_investment_type good.investment_type.name_investment_type
end

json.financial_source do
    json.name_financial_source good.financial_source.name_financial_source
end



