import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="cart"
export default class extends Controller {
  initialize() {
    console.log("Cart controller initialized");
    this.updateTotal();
  }

  updateTotal() {
    const cart = JSON.parse(localStorage.getItem("cart")) || [];
    let total = 0;
    let totalQuantity = 0;
    let itemNames = [];

    // Clear existing cart display
    this.element.innerHTML = "";

    cart.forEach(item => {
      const itemPrice = parseFloat(item.price);
      total += itemPrice * item.quantity;
      totalQuantity += item.quantity;
      itemNames.push(`${item.name} (${item.size} ${item.unit})`);

      // Create a container div for the cart item
      const itemContainer = document.createElement("div");
      itemContainer.classList.add("flex", "justify-between", "items-center", "bg-gray-100", "rounded-lg", "p-4", "mt-2", "shadow-md");

      // Create a div for the item details
      const itemDetails = document.createElement("div");
      itemDetails.classList.add("flex", "flex-col", "gap-1");

      // Add item details
      const itemName = document.createElement("div");
      itemName.classList.add("font-semibold", "text-lg", "text-[#1E3E62]");
      itemName.innerText = `Item: ${item.name}`;
      const itemDetailsText = document.createElement("div");
      itemDetailsText.classList.add("text-sm", "text-gray-700");
      itemDetailsText.innerText = `Price: ₱${itemPrice.toFixed(2)}, Size: ${item.size}, Unit: ${item.unit}, Quantity: ${item.quantity}`;

      // Append details to the itemDetails div
      itemDetails.appendChild(itemName);
      itemDetails.appendChild(itemDetailsText);

      // Create a delete button
      const deleteButton = document.createElement("button");
      deleteButton.innerHTML = '<i class="fas fa-trash"></i>';
      deleteButton.value = JSON.stringify({ id: item.id, size: item.size, unit: item.unit });
      deleteButton.classList.add("bg-red-500", "hover:bg-red-600", "rounded-full", "text-white", "p-2", "ml-4", "transition", "duration-200");
      deleteButton.addEventListener("click", this.removeFromCart.bind(this));

      // Append item details and delete button to the container
      itemContainer.appendChild(itemDetails);
      itemContainer.appendChild(deleteButton);

      // Append the itemContainer to the cart display
      this.element.appendChild(itemContainer);
    });

    // Update the total
    this.updateField("total", `₱${total.toFixed(2)}`);
    this.updateField("order_total", total.toFixed(2));
    this.updateField("order_quantity", totalQuantity);
    this.updateField("order_items", itemNames.join(", "));
  }

  updateField(fieldId, value) {
    const field = document.getElementById(fieldId);
    if (field) {
      field.innerText = value; // Use `innerText` for display-only fields
      if (field.tagName === "INPUT") field.value = value; // Update input fields
    } else {
      console.error(`${fieldId} field not found`);
    }
  }

  clear() {
    localStorage.removeItem("cart");
    window.location.reload();
  }

  removeFromCart(event) {
    const cart = JSON.parse(localStorage.getItem("cart"));
    const { id, size, unit } = JSON.parse(event.target.value);

    const index = cart.findIndex(item => item.id === id && item.size === size && item.unit === unit);
    if (index >= 0) {
      cart.splice(index, 1);
      localStorage.setItem("cart", JSON.stringify(cart));
      this.updateTotal(); // Update the cart without reloading
    }
  }

  checkout(event) {
    event.preventDefault();
    window.location.href = "/customer_orders/new";
  }
}
