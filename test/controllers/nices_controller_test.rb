require "test_helper"

class NicesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get nices_create_url
    assert_response :success
  end

  test "should get destroy" do
    get nices_destroy_url
    assert_response :success
  end
end
