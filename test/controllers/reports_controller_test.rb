require 'test_helper'

class ReportsControllerTest < ActionDispatch::IntegrationTest
  test "should get attendance_tracking" do
    get reports_attendance_tracking_url
    assert_response :success
  end

end
