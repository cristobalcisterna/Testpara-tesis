require "application_system_test_case"

class FinancialSourcesTest < ApplicationSystemTestCase
  setup do
    @financial_source = financial_sources(:one)
  end

  test "visiting the index" do
    visit financial_sources_url
    assert_selector "h1", text: "Financial Sources"
  end

  test "creating a Financial source" do
    visit financial_sources_url
    click_on "New Financial Source"

    fill_in "Detail", with: @financial_source.detail
    fill_in "Name financial source", with: @financial_source.name_financial_source
    click_on "Create Financial source"

    assert_text "Financial source was successfully created"
    click_on "Back"
  end

  test "updating a Financial source" do
    visit financial_sources_url
    click_on "Edit", match: :first

    fill_in "Detail", with: @financial_source.detail
    fill_in "Name financial source", with: @financial_source.name_financial_source
    click_on "Update Financial source"

    assert_text "Financial source was successfully updated"
    click_on "Back"
  end

  test "destroying a Financial source" do
    visit financial_sources_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Financial source was successfully destroyed"
  end
end
