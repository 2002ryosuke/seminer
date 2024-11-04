require "test_helper"

class LinesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get lines_index_url
    assert_response :success
  end

  test "should get create" do
    get lines_create_url
    assert_response :success
  end

  test "should get destory" do
    get lines_destory_url
    assert_response :success
  end
end
