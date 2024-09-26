require "application_system_test_case"

class Admin::MixturesTest < ApplicationSystemTestCase
  setup do
    @admin_mixture = admin_mixtures(:one)
  end

  test "visiting the index" do
    visit admin_mixtures_url
    assert_selector "h1", text: "Mixtures"
  end

  test "should create mixture" do
    visit admin_mixtures_url
    click_on "New mixture"

    fill_in "Amount", with: @admin_mixture.amount
    fill_in "Order", with: @admin_mixture.order_id
    fill_in "Primary color", with: @admin_mixture.primary_color_id
    click_on "Create Mixture"

    assert_text "Mixture was successfully created"
    click_on "Back"
  end

  test "should update Mixture" do
    visit admin_mixture_url(@admin_mixture)
    click_on "Edit this mixture", match: :first

    fill_in "Amount", with: @admin_mixture.amount
    fill_in "Order", with: @admin_mixture.order_id
    fill_in "Primary color", with: @admin_mixture.primary_color_id
    click_on "Update Mixture"

    assert_text "Mixture was successfully updated"
    click_on "Back"
  end

  test "should destroy Mixture" do
    visit admin_mixture_url(@admin_mixture)
    click_on "Destroy this mixture", match: :first

    assert_text "Mixture was successfully destroyed"
  end
end
