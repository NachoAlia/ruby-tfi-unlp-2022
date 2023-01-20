require "test_helper"

class SucursalsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get sucursals_index_url
    assert_response :success
  end
end
