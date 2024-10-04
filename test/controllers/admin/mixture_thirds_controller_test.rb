require "test_helper"

class Admin::MixtureThirdsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_mixture_third = admin_mixture_thirds(:one)
  end

  test "should get index" do
    get admin_mixture_thirds_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_mixture_third_url
    assert_response :success
  end

  test "should create admin_mixture_third" do
    assert_difference("Admin::MixtureThird.count") do
      post admin_mixture_thirds_url, params: { admin_mixture_third: { amount: @admin_mixture_third.amount, mixture_id: @admin_mixture_third.mixture_id, order_id: @admin_mixture_third.order_id, primary_color_id: @admin_mixture_third.primary_color_id } }
    end

    assert_redirected_to admin_mixture_third_url(Admin::MixtureThird.last)
  end

  test "should show admin_mixture_third" do
    get admin_mixture_third_url(@admin_mixture_third)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_mixture_third_url(@admin_mixture_third)
    assert_response :success
  end

  test "should update admin_mixture_third" do
    patch admin_mixture_third_url(@admin_mixture_third), params: { admin_mixture_third: { amount: @admin_mixture_third.amount, mixture_id: @admin_mixture_third.mixture_id, order_id: @admin_mixture_third.order_id, primary_color_id: @admin_mixture_third.primary_color_id } }
    assert_redirected_to admin_mixture_third_url(@admin_mixture_third)
  end

  test "should destroy admin_mixture_third" do
    assert_difference("Admin::MixtureThird.count", -1) do
      delete admin_mixture_third_url(@admin_mixture_third)
    end

    assert_redirected_to admin_mixture_thirds_url
  end
end
