require "test_helper"

class Admin::ColorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_color = admin_colors(:one)
  end

  test "should get index" do
    get admin_colors_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_color_url
    assert_response :success
  end

  test "should create admin_color" do
    assert_difference("Admin::Color.count") do
      post admin_colors_url, params: { admin_color: { code: @admin_color.code, name: @admin_color.name, quantity: @admin_color.quantity, size: @admin_color.size } }
    end

    assert_redirected_to admin_color_url(Admin::Color.last)
  end

  test "should show admin_color" do
    get admin_color_url(@admin_color)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_color_url(@admin_color)
    assert_response :success
  end

  test "should update admin_color" do
    patch admin_color_url(@admin_color), params: { admin_color: { code: @admin_color.code, name: @admin_color.name, quantity: @admin_color.quantity, size: @admin_color.size } }
    assert_redirected_to admin_color_url(@admin_color)
  end

  test "should destroy admin_color" do
    assert_difference("Admin::Color.count", -1) do
      delete admin_color_url(@admin_color)
    end

    assert_redirected_to admin_colors_url
  end
end
