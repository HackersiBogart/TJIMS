require "application_system_test_case"

class Admin::PrimaryColorStocksTest < ApplicationSystemTestCase
  setup do
    @admin_primary_color_stock = admin_primary_color_stocks(:one)
  end

  test "visiting the index" do
    visit admin_primary_color_stocks_url
    assert_selector "h1", text: "Primary color stocks"
  end

  test "should create primary color stock" do
    visit admin_primary_color_stocks_url
    click_on "New primary color stock"

    fill_in "Price", with: @admin_primary_color_stock.price
    fill_in "Quantity", with: @admin_primary_color_stock.quantity
    fill_in "Size", with: @admin_primary_color_stock.size
    click_on "Create Primary color stock"

    assert_text "Primary color stock was successfully created"
    click_on "Back"
  end

  test "should update Primary color stock" do
    visit admin_primary_color_stock_url(@admin_primary_color_stock)
    click_on "Edit this primary color stock", match: :first

    fill_in "Price", with: @admin_primary_color_stock.price
    fill_in "Quantity", with: @admin_primary_color_stock.quantity
    fill_in "Size", with: @admin_primary_color_stock.size
    click_on "Update Primary color stock"

    assert_text "Primary color stock was successfully updated"
    click_on "Back"
  end

  test "should destroy Primary color stock" do
    visit admin_primary_color_stock_url(@admin_primary_color_stock)
    click_on "Destroy this primary color stock", match: :first

    assert_text "Primary color stock was successfully destroyed"
  end
end
