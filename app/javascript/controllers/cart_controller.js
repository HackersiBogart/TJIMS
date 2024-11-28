import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  initialize() {
    console.log("Cart controller initialized");
    this.renderCart();
    this.updateTotal();
  }

  renderCart() {
    const cart = JSON.parse(localStorage.getItem("cart")) || [];
    const cartContainer = document.getElementById("cartItems");

    if (cartContainer) {
      cartContainer.innerHTML = ""; // Clear container before rendering

      cart.forEach((item) => {
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

        itemDetails.innerHTML = `
          <div class="font-semibold text-lg text-[#1E3E62]">Item: ${item.name}</div>
          <div class="text-sm text-gray-700">Price: ₱${parseFloat(item.price).toFixed(2)}</div>
          <div class="text-sm text-gray-700">Size: ${item.size}</div>
          <div class="text-sm text-gray-700">Quantity: ${item.quantity}</div>
        `;

        const deleteButton = document.createElement("button");
        deleteButton.innerHTML = '<i class="fas fa-trash"></i>';
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

        deleteButton.addEventListener("click", () =>
          this.removeFromCart(item.id, item.size)
        );

        itemContainer.appendChild(itemDetails);
        itemContainer.appendChild(deleteButton);
        cartContainer.appendChild(itemContainer);
      });
    } else {
      console.error("Cart container not found");
    }
  }

  updateTotal() {
    const cart = JSON.parse(localStorage.getItem("cart")) || [];
    let total = 0;
    let totalQuantity = 0;

    cart.forEach((item) => {
      total += parseFloat(item.price) * item.quantity;
      totalQuantity += item.quantity;
    });

    const totalDiv = document.getElementById("total");
    if (totalDiv) totalDiv.innerText = `Total: ₱${total.toFixed(2)}`;

    const totalField = document.getElementById("order_total");
    if (totalField) totalField.value = total.toFixed(2);
  }

  removeFromCart(id, size) {
    let cart = JSON.parse(localStorage.getItem("cart")) || [];
    cart = cart.filter((item) => !(item.id === id && item.size === size));
    localStorage.setItem("cart", JSON.stringify(cart));
    this.renderCart();
    this.updateTotal();
  }

  clear() {
    localStorage.removeItem("cart");
    this.renderCart();
    this.updateTotal();
  }

  checkout(event) {
    event.preventDefault();
    window.location.href = "/customer_orders/new";
  }
}
