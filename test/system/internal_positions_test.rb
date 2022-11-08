require "application_system_test_case"

class InternalPositionsTest < ApplicationSystemTestCase
  setup do
    @internal_position = internal_positions(:one)
  end

  test "visiting the index" do
    visit internal_positions_url
    assert_selector "h1", text: "Internal Positions"
  end

  test "creating a Internal position" do
    visit internal_positions_url
    click_on "New Internal Position"

    fill_in "Description", with: @internal_position.description
    check "Is real" if @internal_position.is_real
    fill_in "Name", with: @internal_position.name
    click_on "Create Internal position"

    assert_text "Internal position was successfully created"
    click_on "Back"
  end

  test "updating a Internal position" do
    visit internal_positions_url
    click_on "Edit", match: :first

    fill_in "Description", with: @internal_position.description
    check "Is real" if @internal_position.is_real
    fill_in "Name", with: @internal_position.name
    click_on "Update Internal position"

    assert_text "Internal position was successfully updated"
    click_on "Back"
  end

  test "destroying a Internal position" do
    visit internal_positions_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Internal position was successfully destroyed"
  end
end
