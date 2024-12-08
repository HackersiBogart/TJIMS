import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="cart"
export default class extends Controller {
  initialize() {
    console.log("Cart controller initialized");
    this.updateTotal();
  }

  updateTotal() {
    const cart = JSON.parse(localStorage.getItem("cart")) || [];
    if (!localStorage.getItem("cart")) {
      localStorage.setItem("cart", JSON.stringify([])); // Initialize an empty cart
    }

    let total = 0;
    let totalQuantity = 0;
    let totalSize = [];
    let itemNames = [];
    let itemColors = [];
    let itemProducts = [];

    // Clear previous cart display
    this.element.innerHTML = "";

    // Calculate total, quantity, and collect item details
    cart.forEach(item => {
      const itemPrice = parseFloat(item.price); // Ensure price is a number
      total += itemPrice * item.quantity;
      totalQuantity += item.quantity;
      totalSize.push(item.size);
      itemNames.push(item.name);
      itemColors.push(item.color_id);
      itemProducts.push(item.product_id);

      // Create and append cart item display
      const itemContainer = this.createCartItemElement(item);
      this.element.prepend(itemContainer);
    });

    // Update display fields
    this.updateDisplay("total", `Total: ₱${total.toFixed(2)}`);
    this.updateDisplay("order_total", `₱${total.toFixed(2)}`, true);
    this.updateDisplay("order_size", totalSize.join(", "));
    this.updateDisplay("order_quantity", totalQuantity);
    this.updateDisplay("order_items", itemNames.join(", "));
    this.updateDisplay("order_colors", itemColors.join(", "));
    this.updateDisplay("order_products", itemProducts.join(", "));
  }

  createCartItemElement(item) {
    // Create container for the cart item
    const itemContainer = document.createElement("div");
    itemContainer.classList.add(
      "flex",
      "justify-between",
      "items-center",
      "bg-gray-100",
      "rounded-lg",
      "p-4",
      "mt-2",
      "shadow-md"
    );

    // Create details section
    const itemDetails = document.createElement("div");
    itemDetails.classList.add("flex", "flex-col", "gap-1");

    // Add item details
    this.appendDetail(itemDetails, "Brand", item.color_id, "text-sm", "text-gray-700");
    this.appendDetail(itemDetails, "Product", item.product_id, "text-sm", "text-gray-700");
    this.appendDetail(itemDetails, "Item", item.name, "font-semibold", "text-lg", "text-[#1E3E62]");
    this.appendDetail(itemDetails, "Price", `₱${item.price.toFixed(2)}`, "text-sm", "text-gray-700");
    this.appendDetail(itemDetails, "Size", item.size, "text-sm", "text-gray-700");
    this.appendDetail(itemDetails, "Quantity", item.quantity, "text-sm", "text-gray-700");

    // Add delete button
    const deleteButton = document.createElement("button");
    deleteButton.innerHTML = '<i class="fas fa-trash"></i>';
    deleteButton.value = JSON.stringify({ id: item.id, size: item.size });
    deleteButton.classList.add(
      "bg-red-500",
      "hover:bg-red-600",
      "rounded-full",
      "text-white",
      "p-2",
      "ml-4",
      "transition",
      "duration-200"
    );
    deleteButton.addEventListener("click", this.removeFromCart.bind(this));

    // Append details and button to the container
    itemContainer.appendChild(itemDetails);
    itemContainer.appendChild(deleteButton);

    return itemContainer;
  }

  appendDetail(container, label, value, ...classes) {
    const detail = document.createElement("div");
    detail.classList.add(...classes);
    detail.innerText = `${label}: ${value}`;
    container.appendChild(detail);
  }

  updateDisplay(id, value, isField = false) {
    const element = document.getElementById(id);
    if (element) {
      if (isField) {
        element.value = value;
      } else {
        element.innerText = value;
      }
    } else {
      console.error(`${id} element not found`);
    }
  }

  clear() {
    localStorage.removeItem("cart");
    window.location.reload();
  }

  removeFromCart(event) {
    const cart = JSON.parse(localStorage.getItem("cart"));
    const { id, size } = JSON.parse(event.target.value);
    const index = cart.findIndex(item => item.id === id && item.size === size);
    if (index >= 0) {
      cart.splice(index, 1);
      localStorage.setItem("cart", JSON.stringify(cart));
      this.updateTotal(); // Recalculate the cart
    }
  }

  checkout(event) {
    event.preventDefault();
    window.location.href = "/customer_orders/new";
  }
}
