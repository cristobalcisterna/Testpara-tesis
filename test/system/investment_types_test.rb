require "application_system_test_case"

class InvestmentTypesTest < ApplicationSystemTestCase
  setup do
    @investment_type = investment_types(:one)
  end

  test "visiting the index" do
    visit investment_types_url
    assert_selector "h1", text: "Investment Types"
  end

  test "creating a Investment type" do
    visit investment_types_url
    click_on "New Investment Type"

    fill_in "Detail", with: @investment_type.detail
    fill_in "Name investment type", with: @investment_type.name_investment_type
    click_on "Create Investment type"

    assert_text "Investment type was successfully created"
    click_on "Back"
  end

  test "updating a Investment type" do
    visit investment_types_url
    click_on "Edit", match: :first

    fill_in "Detail", with: @investment_type.detail
    fill_in "Name investment type", with: @investment_type.name_investment_type
    click_on "Update Investment type"

    assert_text "Investment type was successfully updated"
    click_on "Back"
  end

  test "destroying a Investment type" do
    visit investment_types_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Investment type was successfully destroyed"
  end
end
