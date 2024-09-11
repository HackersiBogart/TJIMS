import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="cart"
export default class extends Controller {
  initialize() {
    console.log("cart controller initialized");
    this.updateTotal();
  }

  updateTotal() {
    const cart = JSON.parse(localStorage.getItem("cart")) || [];
    
    let total = 0;

    // Calculate total
    for (let i = 0; i < cart.length; i++) {
      const item = cart[i];
      const itemPrice = parseFloat(item.price); // Ensure price is a number
      total += itemPrice * item.quantity;

      const div = document.createElement("div");
        div.classList.add("mt-2");
        div.innerText = `Item: ${item.name} - ₱${itemPrice.toFixed(2)} - Size: ${item.size} - Quantity: ${item.quantity}`;
  
        const deleteButton = document.createElement("button");
        deleteButton.innerText = "Remove";
        deleteButton.value = JSON.stringify({ id: item.id, size: item.size });
        deleteButton.classList.add("bg-gray-500", "rounded", "text-white", "px-2", "py-1", "ml-2");
        deleteButton.addEventListener("click", this.removeFromCart.bind(this)); // Bind `this` to the method
        div.appendChild(deleteButton);
        this.element.prepend(div);
    }

    // Update the total in the div
    const totalDiv = document.getElementById("total");
    if (totalDiv) {
      totalDiv.innerText = `Total: ₱${total.toFixed(2)}`; // Format the total to 2 decimal places
    } else {
      console.error("Total div not found");
    }

    // Update the total in the text field
    const totalField = document.getElementById("order_total");
    if (totalField) {
      totalField.value = `₱${total.toFixed(2)}`; // Format the total to 2 decimal places
    } else {
      console.error("Total field not found");
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
    window.location.href = "/checkouts/payment_options";
  }
}



