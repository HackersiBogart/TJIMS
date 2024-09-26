require "test_helper"

class Admin::MixControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get mix_deduct_url
    assert_response :success
  end

  test "should get create" do
    get mix_create_url
    assert_response :success
  end

  test "should get index" do
    get mix_index_url
    assert_response :success
  end
end
