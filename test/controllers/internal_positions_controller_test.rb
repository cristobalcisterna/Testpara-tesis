require 'test_helper'

class InternalPositionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @internal_position = internal_positions(:one)
  end

  test "should get index" do
    get internal_positions_url
    assert_response :success
  end

  test "should get new" do
    get new_internal_position_url
    assert_response :success
  end

  test "should create internal_position" do
    assert_difference('InternalPosition.count') do
      post internal_positions_url, params: { internal_position: { description: @internal_position.description, is_real: @internal_position.is_real, name: @internal_position.name } }
    end

    assert_redirected_to internal_position_url(InternalPosition.last)
  end

  test "should show internal_position" do
    get internal_position_url(@internal_position)
    assert_response :success
  end

  test "should get edit" do
    get edit_internal_position_url(@internal_position)
    assert_response :success
  end

  test "should update internal_position" do
    patch internal_position_url(@internal_position), params: { internal_position: { description: @internal_position.description, is_real: @internal_position.is_real, name: @internal_position.name } }
    assert_redirected_to internal_position_url(@internal_position)
  end

  test "should destroy internal_position" do
    assert_difference('InternalPosition.count', -1) do
      delete internal_position_url(@internal_position)
    end

    assert_redirected_to internal_positions_url
  end
end
