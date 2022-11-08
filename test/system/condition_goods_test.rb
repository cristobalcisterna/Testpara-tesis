require "application_system_test_case"

class ConditionGoodsTest < ApplicationSystemTestCase
  setup do
    @condition_good = condition_goods(:one)
  end

  test "visiting the index" do
    visit condition_goods_url
    assert_selector "h1", text: "Condition Goods"
  end

  test "creating a Condition good" do
    visit condition_goods_url
    click_on "New Condition Good"

    fill_in "Condition", with: @condition_good.condition_id
    fill_in "Date entry", with: @condition_good.date_entry
    fill_in "Destruction date", with: @condition_good.destruction_date
    fill_in "Destruction detail", with: @condition_good.destruction_detail
    fill_in "Goods", with: @condition_good.goods_id
    fill_in "Income reason", with: @condition_good.income_reason
    fill_in "Loss detail", with: @condition_good.loss_detail
    fill_in "Lost date", with: @condition_good.lost_date
    fill_in "Repairable", with: @condition_good.repairable
    fill_in "Request date", with: @condition_good.request_date
    fill_in "Request status", with: @condition_good.request_status
    click_on "Create Condition good"

    assert_text "Condition good was successfully created"
    click_on "Back"
  end

  test "updating a Condition good" do
    visit condition_goods_url
    click_on "Edit", match: :first

    fill_in "Condition", with: @condition_good.condition_id
    fill_in "Date entry", with: @condition_good.date_entry
    fill_in "Destruction date", with: @condition_good.destruction_date
    fill_in "Destruction detail", with: @condition_good.destruction_detail
    fill_in "Goods", with: @condition_good.goods_id
    fill_in "Income reason", with: @condition_good.income_reason
    fill_in "Loss detail", with: @condition_good.loss_detail
    fill_in "Lost date", with: @condition_good.lost_date
    fill_in "Repairable", with: @condition_good.repairable
    fill_in "Request date", with: @condition_good.request_date
    fill_in "Request status", with: @condition_good.request_status
    click_on "Update Condition good"

    assert_text "Condition good was successfully updated"
    click_on "Back"
  end

  test "destroying a Condition good" do
    visit condition_goods_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Condition good was successfully destroyed"
  end
end
