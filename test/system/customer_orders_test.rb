require "application_system_test_case"

class CustomerOrdersTest < ApplicationSystemTestCase
  setup do
    @customer_order = customer_orders(:one)
  end

  test "visiting the index" do
    visit customer_orders_url
    assert_selector "h1", text: "Customer orders"
  end

  test "should create customer order" do
    visit customer_orders_url
    click_on "New customer order"

    fill_in "Customer email", with: @customer_order.customer_email
    fill_in "Date of retrieval", with: @customer_order.date_of_retrieval
    fill_in "Items", with: @customer_order.items
    fill_in "Name", with: @customer_order.name
    fill_in "Phone number", with: @customer_order.phone_number
    fill_in "Quantity", with: @customer_order.quantity
    fill_in "Reference number", with: @customer_order.reference_number
    fill_in "Size", with: @customer_order.size
    fill_in "Total", with: @customer_order.total
    click_on "Create Customer order"

    assert_text "Customer order was successfully created"
    click_on "Back"
  end

  test "should update Customer order" do
    visit customer_order_url(@customer_order)
    click_on "Edit this customer order", match: :first

    fill_in "Customer email", with: @customer_order.customer_email
    fill_in "Date of retrieval", with: @customer_order.date_of_retrieval
    fill_in "Items", with: @customer_order.items
    fill_in "Name", with: @customer_order.name
    fill_in "Phone number", with: @customer_order.phone_number
    fill_in "Quantity", with: @customer_order.quantity
    fill_in "Reference number", with: @customer_order.reference_number
    fill_in "Size", with: @customer_order.size
    fill_in "Total", with: @customer_order.total
    click_on "Update Customer order"

    assert_text "Customer order was successfully updated"
    click_on "Back"
  end

  test "should destroy Customer order" do
    visit customer_order_url(@customer_order)
    click_on "Destroy this customer order", match: :first

    assert_text "Customer order was successfully destroyed"
  end
end
