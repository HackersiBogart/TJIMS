import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="cart"
export default class extends Controller {
  initialize() {
    console.log("cart controller initialized");
    this.updateTotal();
  }

  connect() {
    console.log("Cart controller connected");
    this.renderCart(); // Render the cart whenever the controller is connected
    this.updateTotal(); // Update the total as well
  }

  static targets = ["cartContainer", "cartItems", "total", "size", "quantity", "items", "colors", "products"];

  // Helper function to create elements with text
  createElement(tag, text) {
    const element = document.createElement(tag);
    element.classList.add("text-sm", "text-gray-700");
    element.innerText = text;
    return element;
  }

  renderCart() {
    const colors = JSON.parse(localStorage.getItem("colors")) || {};
    const products = JSON.parse(localStorage.getItem("products")) || {};
    const cart = JSON.parse(localStorage.getItem("cart")) || [];

    this.cartContainerTarget.innerHTML = ""; // Clear existing content

    cart.forEach(item => {
      const colorName = colors[item.color_id] || "Unknown";
      const productName = products[item.product_id] || "Unknown";

      const cartItem = document.createElement("div");
      cartItem.textContent = `${item.name} (${item.size} ${item.unit}) - Color: ${colorName}, Product: ${productName}, Quantity: ${item.quantity}`;
      this.cartContainerTarget.appendChild(cartItem);
    });
  }

  updateTotal() {
    const cart = JSON.parse(localStorage.getItem("cart")) || [];
    const colors = JSON.parse(localStorage.getItem("colors")) || {};
    const products = JSON.parse(localStorage.getItem("products")) || {};
    
    let total = 0;
    
    this.cartItemsTarget.innerHTML = ""; // Clear existing cart items

    cart.forEach(item => {
      const itemPrice = parseFloat(item.price);
      total += itemPrice * item.quantity;

      const colorName = colors[item.color_id] || "Unknown";
      const productName = products[item.product_id] || "Unknown";

      // Create the cart item UI as before
      const itemContainer = document.createElement("div");
      itemContainer.classList.add(
        "flex", "justify-between", "items-center", "bg-gray-100", 
        "rounded-lg", "p-4", "mt-2", "shadow-md"
      );

      const itemDetails = document.createElement("div");
      itemDetails.classList.add("flex", "flex-col", "gap-1");

      // Append details using the helper function
      itemDetails.appendChild(this.createElement("div", `Brand: ${colorName}`));
      itemDetails.appendChild(this.createElement("div", `Product: ${productName}`));
      itemDetails.appendChild(this.createElement("div", `Item: ${item.name}`));
      itemDetails.appendChild(this.createElement("div", `Price: ₱${itemPrice.toFixed(2)}`));
      itemDetails.appendChild(this.createElement("div", `Quantity: ${item.quantity}`));

      // Create delete button
      const deleteButton = document.createElement("button");
      deleteButton.innerHTML = '<i class="fas fa-trash"></i>';
      deleteButton.value = JSON.stringify({ id: item.id, size: item.size });
      deleteButton.classList.add(
        "bg-red-500", "hover:bg-red-600", "rounded-full", 
        "text-white", "p-2", "ml-4", "transition", "duration-200"
      );
      deleteButton.addEventListener("click", this.removeFromCart.bind(this));

      itemContainer.appendChild(itemDetails);
      itemContainer.appendChild(deleteButton);

      this.cartItemsTarget.prepend(itemContainer);
    });

    this.totalTarget.innerText = `Total: ₱${total.toFixed(2)}`;
  }

  updateSizeField(size) {
    const sizeField = document.getElementById("order_size");
    if (sizeField) {
      sizeField.value = `${size}`; // Update size field value
    } else {
      console.error("Size field not found");
    }
  }

  updateQuantityField(quantity) {
    const quantityField = document.getElementById("order_quantity");
    if (quantityField) {
      quantityField.value = quantity; // Update quantity field value
    } else {
      console.error("Quantity field not found");
    }
  }

  updateItemField(items) {
    const itemField = document.getElementById("order_items");
    if (itemField) {
      itemField.value = items.join(", "); // Join item names into a single string
    } else {
      console.error("Item field not found");
    }
  }

  updateColorField(color_ids) {
    const colorField = document.getElementById("order_colors");
    if (colorField) {
      colorField.value = color_ids.join(", "); // Join item names into a single string
    } else {
      console.error("Brand field not found");
    }
  }

  updateProductField(product_ids) {
    const productField = document.getElementById("order_products");
    if (productField) {
      productField.value = product_ids.join(", "); // Join item names into a single string
    } else {
      console.error("Product field not found");
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

      this.renderCart(); // Update cart UI without reloading
      this.updateTotal(); // Update the total after removing the item
    }
  }

  checkout(event) {
    event.preventDefault();
    window.location.href = "/customer_orders/new";
  }
}
