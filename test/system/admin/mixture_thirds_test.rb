require "application_system_test_case"

class Admin::MixtureThirdsTest < ApplicationSystemTestCase
  setup do
    @admin_mixture_third = admin_mixture_thirds(:one)
  end

  test "visiting the index" do
    visit admin_mixture_thirds_url
    assert_selector "h1", text: "Mixture thirds"
  end

  test "should create mixture third" do
    visit admin_mixture_thirds_url
    click_on "New mixture third"

    fill_in "Amount", with: @admin_mixture_third.amount
    fill_in "Mixture", with: @admin_mixture_third.mixture_id
    fill_in "Order", with: @admin_mixture_third.order_id
    fill_in "Primary color", with: @admin_mixture_third.primary_color_id
    click_on "Create Mixture third"

    assert_text "Mixture third was successfully created"
    click_on "Back"
  end

  test "should update Mixture third" do
    visit admin_mixture_third_url(@admin_mixture_third)
    click_on "Edit this mixture third", match: :first

    fill_in "Amount", with: @admin_mixture_third.amount
    fill_in "Mixture", with: @admin_mixture_third.mixture_id
    fill_in "Order", with: @admin_mixture_third.order_id
    fill_in "Primary color", with: @admin_mixture_third.primary_color_id
    click_on "Update Mixture third"

    assert_text "Mixture third was successfully updated"
    click_on "Back"
  end

  test "should destroy Mixture third" do
    visit admin_mixture_third_url(@admin_mixture_third)
    click_on "Destroy this mixture third", match: :first

    assert_text "Mixture third was successfully destroyed"
  end
end
