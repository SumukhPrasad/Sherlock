require "test_helper"

class PrintShopControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get print_shop_index_url
    assert_response :success
  end
end
