require "application_system_test_case"

class Admin::ColorsTest < ApplicationSystemTestCase
  setup do
    @admin_color = admin_colors(:one)
  end

  test "visiting the index" do
    visit admin_colors_url
    assert_selector "h1", text: "Colors"
  end

  test "should create color" do
    visit admin_colors_url
    click_on "New color"

    fill_in "Code", with: @admin_color.code
    fill_in "Name", with: @admin_color.name
    fill_in "Quantity", with: @admin_color.quantity
    fill_in "Size", with: @admin_color.size
    click_on "Create Color"

    assert_text "Color was successfully created"
    click_on "Back"
  end

  test "should update Color" do
    visit admin_color_url(@admin_color)
    click_on "Edit this color", match: :first

    fill_in "Code", with: @admin_color.code
    fill_in "Name", with: @admin_color.name
    fill_in "Quantity", with: @admin_color.quantity
    fill_in "Size", with: @admin_color.size
    click_on "Update Color"

    assert_text "Color was successfully updated"
    click_on "Back"
  end

  test "should destroy Color" do
    visit admin_color_url(@admin_color)
    click_on "Destroy this color", match: :first

    assert_text "Color was successfully destroyed"
  end
end
