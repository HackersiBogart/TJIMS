require "test_helper"

class Admin::MixtureDetailsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_mixture_detail = admin_mixture_details(:one)
  end

  test "should get index" do
    get admin_mixture_details_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_mixture_detail_url
    assert_response :success
  end

  test "should create admin_mixture_detail" do
    assert_difference("Admin::MixtureDetail.count") do
      post admin_mixture_details_url, params: { admin_mixture_detail: { amount: @admin_mixture_detail.amount, mixture_id: @admin_mixture_detail.mixture_id, order_id: @admin_mixture_detail.order_id, primary_color_id: @admin_mixture_detail.primary_color_id } }
    end

    assert_redirected_to admin_mixture_detail_url(Admin::MixtureDetail.last)
  end

  test "should show admin_mixture_detail" do
    get admin_mixture_detail_url(@admin_mixture_detail)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_mixture_detail_url(@admin_mixture_detail)
    assert_response :success
  end

  test "should update admin_mixture_detail" do
    patch admin_mixture_detail_url(@admin_mixture_detail), params: { admin_mixture_detail: { amount: @admin_mixture_detail.amount, mixture_id: @admin_mixture_detail.mixture_id, order_id: @admin_mixture_detail.order_id, primary_color_id: @admin_mixture_detail.primary_color_id } }
    assert_redirected_to admin_mixture_detail_url(@admin_mixture_detail)
  end

  test "should destroy admin_mixture_detail" do
    assert_difference("Admin::MixtureDetail.count", -1) do
      delete admin_mixture_detail_url(@admin_mixture_detail)
    end

    assert_redirected_to admin_mixture_details_url
  end
end
