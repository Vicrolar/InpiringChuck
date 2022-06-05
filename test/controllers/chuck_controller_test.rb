require "test_helper"

class ChuckControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get chuck_index_url
    assert_response :success
  end
end
