require 'test_helper'

class AccountancyReportsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get accountancy_reports_index_url
    assert_response :success
  end

  test "should get show" do
    get accountancy_reports_show_url
    assert_response :success
  end

end
