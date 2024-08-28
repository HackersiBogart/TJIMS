require "application_system_test_case"

class Admin::PaintColorsTest < ApplicationSystemTestCase
  setup do
    @admin_paint_color = admin_paint_colors(:one)
  end

  test "visiting the index" do
    visit admin_paint_colors_url
    assert_selector "h1", text: "Paint colors"
  end

  test "should create paint color" do
    visit admin_paint_colors_url
    click_on "New paint color"

    check "Active" if @admin_paint_color.active
    fill_in "Code", with: @admin_paint_color.code
    fill_in "Color", with: @admin_paint_color.color_id
    fill_in "Name", with: @admin_paint_color.name
    fill_in "Price", with: @admin_paint_color.price
    fill_in "Quantity", with: @admin_paint_color.quantity
    fill_in "Size", with: @admin_paint_color.size
    click_on "Create Paint color"

    assert_text "Paint color was successfully created"
    click_on "Back"
  end

  test "should update Paint color" do
    visit admin_paint_color_url(@admin_paint_color)
    click_on "Edit this paint color", match: :first

    check "Active" if @admin_paint_color.active
    fill_in "Code", with: @admin_paint_color.code
    fill_in "Color", with: @admin_paint_color.color_id
    fill_in "Name", with: @admin_paint_color.name
    fill_in "Price", with: @admin_paint_color.price
    fill_in "Quantity", with: @admin_paint_color.quantity
    fill_in "Size", with: @admin_paint_color.size
    click_on "Update Paint color"

    assert_text "Paint color was successfully updated"
    click_on "Back"
  end

  test "should destroy Paint color" do
    visit admin_paint_color_url(@admin_paint_color)
    click_on "Destroy this paint color", match: :first

    assert_text "Paint color was successfully destroyed"
  end
end
