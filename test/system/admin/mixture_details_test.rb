require "application_system_test_case"

class Admin::MixtureDetailsTest < ApplicationSystemTestCase
  setup do
    @admin_mixture_detail = admin_mixture_details(:one)
  end

  test "visiting the index" do
    visit admin_mixture_details_url
    assert_selector "h1", text: "Mixture details"
  end

  test "should create mixture detail" do
    visit admin_mixture_details_url
    click_on "New mixture detail"

    fill_in "Amount", with: @admin_mixture_detail.amount
    fill_in "Mixture", with: @admin_mixture_detail.mixture_id
    fill_in "Order", with: @admin_mixture_detail.order_id
    fill_in "Primary color", with: @admin_mixture_detail.primary_color_id
    click_on "Create Mixture detail"

    assert_text "Mixture detail was successfully created"
    click_on "Back"
  end

  test "should update Mixture detail" do
    visit admin_mixture_detail_url(@admin_mixture_detail)
    click_on "Edit this mixture detail", match: :first

    fill_in "Amount", with: @admin_mixture_detail.amount
    fill_in "Mixture", with: @admin_mixture_detail.mixture_id
    fill_in "Order", with: @admin_mixture_detail.order_id
    fill_in "Primary color", with: @admin_mixture_detail.primary_color_id
    click_on "Update Mixture detail"

    assert_text "Mixture detail was successfully updated"
    click_on "Back"
  end

  test "should destroy Mixture detail" do
    visit admin_mixture_detail_url(@admin_mixture_detail)
    click_on "Destroy this mixture detail", match: :first

    assert_text "Mixture detail was successfully destroyed"
  end
end
