import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="cart"
export default class extends Controller {
  initialize() {
    console.log("cart controller initialized");
    this.updateTotal();
  }

  updateTotal() {
    const cart = JSON.parse(localStorage.getItem("cart")) || [];

    let total = 0;
    let totalQuantity = 0;
    let totalSize = 0;
    let itemNames = [];
    let itemColors = [];
    let itemProducts = [];

    // Clear previous cart items to avoid duplication
    this.element.innerHTML = "";

    // Calculate totals and populate item details
    cart.forEach(item => {
      const itemPrice = parseFloat(item.price); // Ensure price is a number
      total += itemPrice * item.quantity;
      totalQuantity += item.quantity;
      totalSize += parseFloat(item.size); // Convert size to a number
      itemNames.push(item.name);
      itemColors.push(item.color_id);
      itemProducts.push(item.product_id);

      // Create a container for the cart item
      const itemContainer = document.createElement("div");
      itemContainer.classList.add("flex", "justify-between", "items-center", "bg-gray-100", "rounded-lg", "p-4", "mt-2", "shadow-md");

      // Create a div for item details
      const itemDetails = document.createElement("div");
      itemDetails.classList.add("flex", "flex-col", "gap-1");

      // Add details to the itemDetails div
      itemDetails.innerHTML = `
        <div class="text-sm text-gray-700">Product: ${item.product_id}</div>
        <div class="text-sm text-gray-700">Color: ${item.color_id}</div>
        <div class="font-semibold text-lg text-[#1E3E62]">Item: ${item.name}</div>
        <div class="text-sm text-gray-700">Price: ₱${itemPrice.toFixed(2)}</div>
        <div class="text-sm text-gray-700">Size: ${item.size}</div>
        <div class="text-sm text-gray-700">Quantity: ${item.quantity}</div>
      `;

      // Create a delete button
      const deleteButton = document.createElement("button");
      deleteButton.innerHTML = '<i class="fas fa-trash"></i>';
      deleteButton.value = JSON.stringify({ id: item.id, size: item.size });
      deleteButton.classList.add("bg-red-500", "hover:bg-red-600", "rounded-full", "text-white", "p-2", "ml-4", "transition", "duration-200");
      deleteButton.addEventListener("click", this.removeFromCart.bind(this));

      // Append details and button to the container
      itemContainer.appendChild(itemDetails);
      itemContainer.appendChild(deleteButton);

      // Append the container to the main element
      this.element.appendChild(itemContainer);
    });

    // Update totals in various fields
    this.updateText("total", `Total: ₱${total.toFixed(2)}`);
    this.updateField("order_total", `₱${total.toFixed(2)}`);
    this.updateField("order_size", totalSize.toString());
    this.updateField("order_quantity", totalQuantity.toString());
    this.updateField("order_items", itemNames.join(", "));
  }

  updateText(id, text) {
    const element = document.getElementById(id);
    if (element) {
      element.innerText = text;
    } else {
      console.error(`${id} element not found`);
    }
  }

  updateField(id, value) {
    const field = document.getElementById(id);
    if (field) {
      field.value = value;
    } else {
      console.error(`${id} field not found`);
    }
  }

  clear() {
    localStorage.removeItem("cart");
    window.location.reload();
  }

  removeFromCart(event) {
    const cart = JSON.parse(localStorage.getItem("cart"));
    const values = JSON.parse(event.target.value);
    const { id, size } = values;
    const index = cart.findIndex(item => item.id === id && item.size === size);
    if (index >= 0) {
      cart.splice(index, 1);
      localStorage.setItem("cart", JSON.stringify(cart));
      window.location.reload();
    }
  }

  checkout(event) {
    event.preventDefault();
    window.location.href = "/customer_orders/new";
  }
}
