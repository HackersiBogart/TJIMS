require "test_helper"

class Admin::PrimaryColorStocksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_primary_color_stock = admin_primary_color_stocks(:one)
  end

  test "should get index" do
    get admin_primary_color_stocks_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_primary_color_stock_url
    assert_response :success
  end

  test "should create admin_primary_color_stock" do
    assert_difference("Admin::PrimaryColorStock.count") do
      post admin_primary_color_stocks_url, params: { admin_primary_color_stock: { price: @admin_primary_color_stock.price, quantity: @admin_primary_color_stock.quantity, size: @admin_primary_color_stock.size } }
    end

    assert_redirected_to admin_primary_color_stock_url(Admin::PrimaryColorStock.last)
  end

  test "should show admin_primary_color_stock" do
    get admin_primary_color_stock_url(@admin_primary_color_stock)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_primary_color_stock_url(@admin_primary_color_stock)
    assert_response :success
  end

  test "should update admin_primary_color_stock" do
    patch admin_primary_color_stock_url(@admin_primary_color_stock), params: { admin_primary_color_stock: { price: @admin_primary_color_stock.price, quantity: @admin_primary_color_stock.quantity, size: @admin_primary_color_stock.size } }
    assert_redirected_to admin_primary_color_stock_url(@admin_primary_color_stock)
  end

  test "should destroy admin_primary_color_stock" do
    assert_difference("Admin::PrimaryColorStock.count", -1) do
      delete admin_primary_color_stock_url(@admin_primary_color_stock)
    end

    assert_redirected_to admin_primary_color_stocks_url
  end
end
