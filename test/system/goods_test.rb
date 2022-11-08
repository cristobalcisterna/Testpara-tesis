require "application_system_test_case"

class GoodsTest < ApplicationSystemTestCase
  setup do
    @good = goods(:one)
  end

  test "visiting the index" do
    visit goods_url
    assert_selector "h1", text: "Goods"
  end

  test "creating a Good" do
    visit goods_url
    click_on "New Good"

    fill_in "Amount", with: @good.amount
    fill_in "Date purchase", with: @good.date_purchase
    fill_in "Date release", with: @good.date_release
    fill_in "Duty manager", with: @good.duty_manager_id
    fill_in "Financial source", with: @good.financial_source
    fill_in "Good description", with: @good.good_description
    fill_in "Identification number good", with: @good.identification_number_good
    fill_in "Identification number usach", with: @good.identification_number_usach
    fill_in "Internal number", with: @good.internal_number
    fill_in "Investment type", with: @good.investment_type
    fill_in "Location good", with: @good.location_good
    fill_in "Namegood", with: @good.namegood
    fill_in "Office", with: @good.office_id
    fill_in "Serie number", with: @good.serie_number
    fill_in "Trademark", with: @good.trademark
    click_on "Create Good"

    assert_text "Good was successfully created"
    click_on "Back"
  end

  test "updating a Good" do
    visit goods_url
    click_on "Edit", match: :first

    fill_in "Amount", with: @good.amount
    fill_in "Date purchase", with: @good.date_purchase
    fill_in "Date release", with: @good.date_release
    fill_in "Duty manager", with: @good.duty_manager_id
    fill_in "Financial source", with: @good.financial_source
    fill_in "Good description", with: @good.good_description
    fill_in "Identification number good", with: @good.identification_number_good
    fill_in "Identification number usach", with: @good.identification_number_usach
    fill_in "Internal number", with: @good.internal_number
    fill_in "Investment type", with: @good.investment_type
    fill_in "Location good", with: @good.location_good
    fill_in "Namegood", with: @good.namegood
    fill_in "Office", with: @good.office_id
    fill_in "Serie number", with: @good.serie_number
    fill_in "Trademark", with: @good.trademark
    click_on "Update Good"

    assert_text "Good was successfully updated"
    click_on "Back"
  end

  test "destroying a Good" do
    visit goods_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Good was successfully destroyed"
  end
end
