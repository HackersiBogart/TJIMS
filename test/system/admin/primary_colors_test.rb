require "application_system_test_case"

class Admin::PrimaryColorsTest < ApplicationSystemTestCase
  setup do
    @admin_primary_color = admin_primary_colors(:one)
  end

  test "visiting the index" do
    visit admin_primary_colors_url
    assert_selector "h1", text: "Primary colors"
  end

  test "should create primary color" do
    visit admin_primary_colors_url
    click_on "New primary color"

    check "Active" if @admin_primary_color.active
    fill_in "Color code", with: @admin_primary_color.color_code
    fill_in "Color name", with: @admin_primary_color.color_name
    fill_in "Price", with: @admin_primary_color.price
    fill_in "Stocks", with: @admin_primary_color.stocks
    click_on "Create Primary color"

    assert_text "Primary color was successfully created"
    click_on "Back"
  end

  test "should update Primary color" do
    visit admin_primary_color_url(@admin_primary_color)
    click_on "Edit this primary color", match: :first

    check "Active" if @admin_primary_color.active
    fill_in "Color code", with: @admin_primary_color.color_code
    fill_in "Color name", with: @admin_primary_color.color_name
    fill_in "Price", with: @admin_primary_color.price
    fill_in "Stocks", with: @admin_primary_color.stocks
    click_on "Update Primary color"

    assert_text "Primary color was successfully updated"
    click_on "Back"
  end

  test "should destroy Primary color" do
    visit admin_primary_color_url(@admin_primary_color)
    click_on "Destroy this primary color", match: :first

    assert_text "Primary color was successfully destroyed"
  end
end
