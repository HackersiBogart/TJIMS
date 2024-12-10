import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="cart"
export default class extends Controller {
  static targets = ["cartItems", "total", "orderItems", "orderSize", "orderQuantity", "paintColorId", "colorId", "productId"];

  initialize() {
    console.log("Cart controller initialized");
    this.updateTotal();
  }

  // Updates the cart's total and items UI
  updateTotal() {
    const cart = JSON.parse(localStorage.getItem("cart")) || [];
    console.log("Cart from localStorage:", cart);

    let total = 0;

    // Clear the cart items container
    this.cartItemsTarget.innerHTML = "";

    // Iterate over cart items and dynamically generate the UI
    cart.forEach((item) => {
      const itemPrice = parseFloat(item.price);
      total += itemPrice * item.quantity;

      const itemContainer = this.createCartItem(item);
      this.cartItemsTarget.appendChild(itemContainer);
    });

    // Update the total price
    this.totalTarget.innerText = `Total: ₱${total.toFixed(2)}`;

    // Update hidden form fields
    this.updateFields(cart);
  }

  // Dynamically creates a cart item DOM element
  createCartItem(item) {
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

    const itemDetails = document.createElement("div");
    itemDetails.classList.add("flex", "flex-col", "gap-1");

    const itemName = document.createElement("div");
    itemName.classList.add("font-semibold", "text-lg", "text-[#1E3E62]");
    itemName.innerText = `Item: ${item.name}`;

    const itemProduct = document.createElement("div");
    itemProduct.classList.add("text-sm", "text-gray-700");
    itemProduct.innerText = `Product: ${item.product}`;

    const itemColor = document.createElement("div");
    itemColor.classList.add("text-sm", "text-gray-700");
    itemColor.innerText = `Brand: ${item.color}`;

    const itemPriceText = document.createElement("div");
    itemPriceText.classList.add("text-sm", "text-gray-700");
    itemPriceText.innerText = `Price: ₱${parseFloat(item.price).toFixed(2)}`;

    const itemQuantity = document.createElement("div");
    itemQuantity.classList.add("text-sm", "text-gray-700");
    itemQuantity.innerText = `Quantity: ${item.quantity}`;

    const itemSize = document.createElement("div");
    itemSize.classList.add("text-sm", "text-gray-700");
    itemSize.innerText = `Size: ${item.size}`;

    itemDetails.appendChild(itemName);
    itemDetails.appendChild(itemProduct);
    itemDetails.appendChild(itemColor);
    itemDetails.appendChild(itemPriceText);
    itemDetails.appendChild(itemQuantity);
    itemDetails.appendChild(itemSize);

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

    itemContainer.appendChild(itemDetails);
    itemContainer.appendChild(deleteButton);

    return itemContainer;
  }

  // Updates hidden fields based on the cart contents
  updateFields(cart) {
    const totalQuantity = cart.reduce((acc, item) => acc + item.quantity, 0);

    this.orderItemsTarget.value = cart.map((item) => item.name).join(", ");
    this.orderSizeTarget.value = cart.map((item) => item.size).join(", ");
    this.orderQuantityTarget.value = totalQuantity;
    this.paintColorIdTarget.value = cart.map((item) => item.paintColorId).join(", ");
    this.colorIdTarget.value = cart.map((item) => item.colorId).join(", ");
    this.productIdTarget.value = cart.map((item) => item.productId).join(", ");
  }

  // Clears the cart and reloads the page
  clear() {
    localStorage.removeItem("cart");
    this.updateTotal(); // Update UI without reloading
  }

  // Removes an item from the cart
  removeFromCart(event) {
    const cart = JSON.parse(localStorage.getItem("cart")) || [];
    const values = JSON.parse(event.currentTarget.value);
    const { id, size } = values;

    const index = cart.findIndex((item) => item.id === id && item.size === size);
    if (index >= 0) {
      cart.splice(index, 1);
      localStorage.setItem("cart", JSON.stringify(cart));
      this.updateTotal(); // Update the UI after removal
    }
  }

  // Proceeds to the checkout page
  checkout(event) {
    event.preventDefault();
    window.location.href = "/customer_orders/new";
  }
}
