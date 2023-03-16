require "test_helper"

class Admin::SportsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_sports_index_url
    assert_response :success
  end

  test "should get edit" do
    get admin_sports_edit_url
    assert_response :success
  end
end
