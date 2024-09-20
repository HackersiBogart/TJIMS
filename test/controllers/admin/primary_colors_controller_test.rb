require "test_helper"

class Admin::PrimaryColorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_primary_color = admin_primary_colors(:one)
  end

  test "should get index" do
    get admin_primary_colors_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_primary_color_url
    assert_response :success
  end

  test "should create admin_primary_color" do
    assert_difference("Admin::PrimaryColor.count") do
      post admin_primary_colors_url, params: { admin_primary_color: { active: @admin_primary_color.active, color_code: @admin_primary_color.color_code, color_name: @admin_primary_color.color_name, price: @admin_primary_color.price, stocks: @admin_primary_color.stocks } }
    end

    assert_redirected_to admin_primary_color_url(Admin::PrimaryColor.last)
  end

  test "should show admin_primary_color" do
    get admin_primary_color_url(@admin_primary_color)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_primary_color_url(@admin_primary_color)
    assert_response :success
  end

  test "should update admin_primary_color" do
    patch admin_primary_color_url(@admin_primary_color), params: { admin_primary_color: { active: @admin_primary_color.active, color_code: @admin_primary_color.color_code, color_name: @admin_primary_color.color_name, price: @admin_primary_color.price, stocks: @admin_primary_color.stocks } }
    assert_redirected_to admin_primary_color_url(@admin_primary_color)
  end

  test "should destroy admin_primary_color" do
    assert_difference("Admin::PrimaryColor.count", -1) do
      delete admin_primary_color_url(@admin_primary_color)
    end

    assert_redirected_to admin_primary_colors_url
  end
end
