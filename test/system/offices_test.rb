require "application_system_test_case"

class OfficesTest < ApplicationSystemTestCase
  setup do
    @office = offices(:one)
  end

  test "visiting the index" do
    visit offices_url
    assert_selector "h1", text: "Offices"
  end

  test "creating a Office" do
    visit offices_url
    click_on "New Office"

    fill_in "Building", with: @office.building_id
    fill_in "Campus identification", with: @office.campus_identification
    fill_in "Duty manager", with: @office.duty_manager_id
    fill_in "Hours available", with: @office.hours_available
    fill_in "Identification number office", with: @office.identification_number_office
    fill_in "Location", with: @office.location
    fill_in "Name office", with: @office.name_office
    fill_in "Office description", with: @office.office_description
    fill_in "Square meter", with: @office.square_meter
    click_on "Create Office"

    assert_text "Office was successfully created"
    click_on "Back"
  end

  test "updating a Office" do
    visit offices_url
    click_on "Edit", match: :first

    fill_in "Building", with: @office.building_id
    fill_in "Campus identification", with: @office.campus_identification
    fill_in "Duty manager", with: @office.duty_manager_id
    fill_in "Hours available", with: @office.hours_available
    fill_in "Identification number office", with: @office.identification_number_office
    fill_in "Location", with: @office.location
    fill_in "Name office", with: @office.name_office
    fill_in "Office description", with: @office.office_description
    fill_in "Square meter", with: @office.square_meter
    click_on "Update Office"

    assert_text "Office was successfully updated"
    click_on "Back"
  end

  test "destroying a Office" do
    visit offices_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Office was successfully destroyed"
  end
end
