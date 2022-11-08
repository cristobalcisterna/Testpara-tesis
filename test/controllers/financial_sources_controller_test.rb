require 'test_helper'

class FinancialSourcesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @financial_source = financial_sources(:one)
  end

  test "should get index" do
    get financial_sources_url
    assert_response :success
  end

  test "should get new" do
    get new_financial_source_url
    assert_response :success
  end

  test "should create financial_source" do
    assert_difference('FinancialSource.count') do
      post financial_sources_url, params: { financial_source: { detail: @financial_source.detail, name_financial_source: @financial_source.name_financial_source } }
    end

    assert_redirected_to financial_source_url(FinancialSource.last)
  end

  test "should show financial_source" do
    get financial_source_url(@financial_source)
    assert_response :success
  end

  test "should get edit" do
    get edit_financial_source_url(@financial_source)
    assert_response :success
  end

  test "should update financial_source" do
    patch financial_source_url(@financial_source), params: { financial_source: { detail: @financial_source.detail, name_financial_source: @financial_source.name_financial_source } }
    assert_redirected_to financial_source_url(@financial_source)
  end

  test "should destroy financial_source" do
    assert_difference('FinancialSource.count', -1) do
      delete financial_source_url(@financial_source)
    end

    assert_redirected_to financial_sources_url
  end
end
