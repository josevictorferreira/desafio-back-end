require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index and must be a form present" do
    get root_path
    assert_response :success
    assert_select "form", 1
  end
end
