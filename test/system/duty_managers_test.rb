require "application_system_test_case"

class DutyManagersTest < ApplicationSystemTestCase
  setup do
    @duty_manager = duty_managers(:one)
  end

  test "visiting the index" do
    visit duty_managers_url
    assert_selector "h1", text: "Duty Managers"
  end

  test "creating a Duty manager" do
    visit duty_managers_url
    click_on "New Duty Manager"

    fill_in "Name duty manager", with: @duty_manager.name_duty_manager
    fill_in "Rut", with: @duty_manager.rut
    fill_in "Unit", with: @duty_manager.unit_id
    click_on "Create Duty manager"

    assert_text "Duty manager was successfully created"
    click_on "Back"
  end

  test "updating a Duty manager" do
    visit duty_managers_url
    click_on "Edit", match: :first

    fill_in "Name duty manager", with: @duty_manager.name_duty_manager
    fill_in "Rut", with: @duty_manager.rut
    fill_in "Unit", with: @duty_manager.unit_id
    click_on "Update Duty manager"

    assert_text "Duty manager was successfully updated"
    click_on "Back"
  end

  test "destroying a Duty manager" do
    visit duty_managers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Duty manager was successfully destroyed"
  end
end
