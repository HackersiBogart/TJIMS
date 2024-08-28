require "test_helper"

class Admin::PaintColorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_paint_color = admin_paint_colors(:one)
  end

  test "should get index" do
    get admin_paint_colors_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_paint_color_url
    assert_response :success
  end

  test "should create admin_paint_color" do
    assert_difference("Admin::PaintColor.count") do
      post admin_paint_colors_url, params: { admin_paint_color: { active: @admin_paint_color.active, code: @admin_paint_color.code, color_id: @admin_paint_color.color_id, name: @admin_paint_color.name, price: @admin_paint_color.price, quantity: @admin_paint_color.quantity, size: @admin_paint_color.size } }
    end

    assert_redirected_to admin_paint_color_url(Admin::PaintColor.last)
  end

  test "should show admin_paint_color" do
    get admin_paint_color_url(@admin_paint_color)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_paint_color_url(@admin_paint_color)
    assert_response :success
  end

  test "should update admin_paint_color" do
    patch admin_paint_color_url(@admin_paint_color), params: { admin_paint_color: { active: @admin_paint_color.active, code: @admin_paint_color.code, color_id: @admin_paint_color.color_id, name: @admin_paint_color.name, price: @admin_paint_color.price, quantity: @admin_paint_color.quantity, size: @admin_paint_color.size } }
    assert_redirected_to admin_paint_color_url(@admin_paint_color)
  end

  test "should destroy admin_paint_color" do
    assert_difference("Admin::PaintColor.count", -1) do
      delete admin_paint_color_url(@admin_paint_color)
    end

    assert_redirected_to admin_paint_colors_url
  end
end
