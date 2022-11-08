require 'test_helper'

class DutyManagersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @duty_manager = duty_managers(:one)
  end

  test "should get index" do
    get duty_managers_url
    assert_response :success
  end

  test "should get new" do
    get new_duty_manager_url
    assert_response :success
  end

  test "should create duty_manager" do
    assert_difference('DutyManager.count') do
      post duty_managers_url, params: { duty_manager: { name_duty_manager: @duty_manager.name_duty_manager, rut: @duty_manager.rut, unit_id: @duty_manager.unit_id } }
    end

    assert_redirected_to duty_manager_url(DutyManager.last)
  end

  test "should show duty_manager" do
    get duty_manager_url(@duty_manager)
    assert_response :success
  end

  test "should get edit" do
    get edit_duty_manager_url(@duty_manager)
    assert_response :success
  end

  test "should update duty_manager" do
    patch duty_manager_url(@duty_manager), params: { duty_manager: { name_duty_manager: @duty_manager.name_duty_manager, rut: @duty_manager.rut, unit_id: @duty_manager.unit_id } }
    assert_redirected_to duty_manager_url(@duty_manager)
  end

  test "should destroy duty_manager" do
    assert_difference('DutyManager.count', -1) do
      delete duty_manager_url(@duty_manager)
    end

    assert_redirected_to duty_managers_url
  end
end
