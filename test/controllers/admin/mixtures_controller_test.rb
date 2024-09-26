require "test_helper"

class Admin::MixturesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_mixture = admin_mixtures(:one)
  end

  test "should get index" do
    get admin_mixtures_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_mixture_url
    assert_response :success
  end

  test "should create admin_mixture" do
    assert_difference("Admin::Mixture.count") do
      post admin_mixtures_url, params: { admin_mixture: { amount: @admin_mixture.amount, order_id: @admin_mixture.order_id, primary_color_id: @admin_mixture.primary_color_id } }
    end

    assert_redirected_to admin_mixture_url(Admin::Mixture.last)
  end

  test "should show admin_mixture" do
    get admin_mixture_url(@admin_mixture)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_mixture_url(@admin_mixture)
    assert_response :success
  end

  test "should update admin_mixture" do
    patch admin_mixture_url(@admin_mixture), params: { admin_mixture: { amount: @admin_mixture.amount, order_id: @admin_mixture.order_id, primary_color_id: @admin_mixture.primary_color_id } }
    assert_redirected_to admin_mixture_url(@admin_mixture)
  end

  test "should destroy admin_mixture" do
    assert_difference("Admin::Mixture.count", -1) do
      delete admin_mixture_url(@admin_mixture)
    end

    assert_redirected_to admin_mixtures_url
  end
end
