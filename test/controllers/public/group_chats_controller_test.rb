require "test_helper"

class Public::GroupChatsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_group_chats_show_url
    assert_response :success
  end
end
