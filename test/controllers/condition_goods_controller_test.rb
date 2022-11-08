require 'test_helper'

class ConditionGoodsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @condition_good = condition_goods(:one)
  end

  test "should get index" do
    get condition_goods_url
    assert_response :success
  end

  test "should get new" do
    get new_condition_good_url
    assert_response :success
  end

  test "should create condition_good" do
    assert_difference('ConditionGood.count') do
      post condition_goods_url, params: { condition_good: { condition_id: @condition_good.condition_id, date_entry: @condition_good.date_entry, destruction_date: @condition_good.destruction_date, destruction_detail: @condition_good.destruction_detail, goods_id: @condition_good.goods_id, income_reason: @condition_good.income_reason, loss_detail: @condition_good.loss_detail, lost_date: @condition_good.lost_date, repairable: @condition_good.repairable, request_date: @condition_good.request_date, request_status: @condition_good.request_status } }
    end

    assert_redirected_to condition_good_url(ConditionGood.last)
  end

  test "should show condition_good" do
    get condition_good_url(@condition_good)
    assert_response :success
  end

  test "should get edit" do
    get edit_condition_good_url(@condition_good)
    assert_response :success
  end

  test "should update condition_good" do
    patch condition_good_url(@condition_good), params: { condition_good: { condition_id: @condition_good.condition_id, date_entry: @condition_good.date_entry, destruction_date: @condition_good.destruction_date, destruction_detail: @condition_good.destruction_detail, goods_id: @condition_good.goods_id, income_reason: @condition_good.income_reason, loss_detail: @condition_good.loss_detail, lost_date: @condition_good.lost_date, repairable: @condition_good.repairable, request_date: @condition_good.request_date, request_status: @condition_good.request_status } }
    assert_redirected_to condition_good_url(@condition_good)
  end

  test "should destroy condition_good" do
    assert_difference('ConditionGood.count', -1) do
      delete condition_good_url(@condition_good)
    end

    assert_redirected_to condition_goods_url
  end
end
