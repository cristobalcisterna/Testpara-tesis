require 'test_helper'

class GoodsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @good = goods(:one)
  end

  test "should get index" do
    get goods_url
    assert_response :success
  end

  test "should get new" do
    get new_good_url
    assert_response :success
  end

  test "should create good" do
    assert_difference('Good.count') do
      post goods_url, params: { good: { amount: @good.amount, date_purchase: @good.date_purchase, date_release: @good.date_release, duty_manager_id: @good.duty_manager_id, financial_source: @good.financial_source, good_description: @good.good_description, identification_number_good: @good.identification_number_good, identification_number_usach: @good.identification_number_usach, internal_number: @good.internal_number, investment_type: @good.investment_type, location_good: @good.location_good, namegood: @good.namegood, office_id: @good.office_id, serie_number: @good.serie_number, trademark: @good.trademark } }
    end

    assert_redirected_to good_url(Good.last)
  end

  test "should show good" do
    get good_url(@good)
    assert_response :success
  end

  test "should get edit" do
    get edit_good_url(@good)
    assert_response :success
  end

  test "should update good" do
    patch good_url(@good), params: { good: { amount: @good.amount, date_purchase: @good.date_purchase, date_release: @good.date_release, duty_manager_id: @good.duty_manager_id, financial_source: @good.financial_source, good_description: @good.good_description, identification_number_good: @good.identification_number_good, identification_number_usach: @good.identification_number_usach, internal_number: @good.internal_number, investment_type: @good.investment_type, location_good: @good.location_good, namegood: @good.namegood, office_id: @good.office_id, serie_number: @good.serie_number, trademark: @good.trademark } }
    assert_redirected_to good_url(@good)
  end

  test "should destroy good" do
    assert_difference('Good.count', -1) do
      delete good_url(@good)
    end

    assert_redirected_to goods_url
  end
end
