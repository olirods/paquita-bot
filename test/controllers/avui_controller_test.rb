require "test_helper"

class AvuiControllerTest < ActionDispatch::IntegrationTest
  test "should get poc" do
    get avui_poc_url
    assert_response :success
  end
end
