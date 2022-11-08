require 'test_helper'

class OfficesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @office = offices(:one)
  end

  test "should get index" do
    get offices_url
    assert_response :success
  end

  test "should get new" do
    get new_office_url
    assert_response :success
  end

  test "should create office" do
    assert_difference('Office.count') do
      post offices_url, params: { office: { building_id: @office.building_id, campus_identification: @office.campus_identification, duty_manager_id: @office.duty_manager_id, hours_available: @office.hours_available, identification_number_office: @office.identification_number_office, location: @office.location, name_office: @office.name_office, office_description: @office.office_description, square_meter: @office.square_meter } }
    end

    assert_redirected_to office_url(Office.last)
  end

  test "should show office" do
    get office_url(@office)
    assert_response :success
  end

  test "should get edit" do
    get edit_office_url(@office)
    assert_response :success
  end

  test "should update office" do
    patch office_url(@office), params: { office: { building_id: @office.building_id, campus_identification: @office.campus_identification, duty_manager_id: @office.duty_manager_id, hours_available: @office.hours_available, identification_number_office: @office.identification_number_office, location: @office.location, name_office: @office.name_office, office_description: @office.office_description, square_meter: @office.square_meter } }
    assert_redirected_to office_url(@office)
  end

  test "should destroy office" do
    assert_difference('Office.count', -1) do
      delete office_url(@office)
    end

    assert_redirected_to offices_url
  end
end
