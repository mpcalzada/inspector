require 'test_helper'

class DashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get home_dashboard" do
    get dashboard_home_dashboard_url
    assert_response :success
  end

  test "should get accountancy_dashboard" do
    get dashboard_accountancy_dashboard_url
    assert_response :success
  end

  test "should get human_resources_dashboard" do
    get dashboard_human_resources_dashboard_url
    assert_response :success
  end

  test "should get reports_dashboard" do
    get dashboard_reports_dashboard_url
    assert_response :success
  end

end
