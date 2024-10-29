require "test_helper"

class Admin::MovementHistoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get add_stock" do
    get admin_movement_histories_add_stock_url
    assert_response :success
  end

  test "should get deduct_stock" do
    get admin_movement_histories_deduct_stock_url
    assert_response :success
  end
end
