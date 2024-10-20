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
    let totalQuantity = 0;
    let totalSize = 0;
    let itemNames = [];

    // Calculate total, quantity, and collect item names
    for (let i = 0; i < cart.length; i++) {
      const item = cart[i];
      const itemPrice = parseFloat(item.price); // Ensure price is a number
      total += itemPrice * item.quantity;
      totalQuantity += item.quantity; // Accumulate quantity
      totalSize += item.size; // Accumulate quantity
      itemNames.push(item.name); // Collect item names

      // Create a container div for the cart item
      const itemContainer = document.createElement("div");
      itemContainer.classList.add("flex", "justify-between", "items-center", "bg-gray-100", "rounded-lg", "p-4", "mt-2", "shadow-md");

      // Create a div for the item details
      const itemDetails = document.createElement("div");
      itemDetails.classList.add("flex", "flex-col", "gap-1");

      // Add item name
      const itemName = document.createElement("div");
      itemName.classList.add("font-semibold", "text-lg", "text-[#1E3E62]");
      itemName.innerText = `Item: ${item.name}`;

      // Add item price
      const itemPriceText = document.createElement("div");
      itemPriceText.classList.add("text-sm", "text-gray-700");
      itemPriceText.innerText = `Price: ₱${itemPrice.toFixed(2)}`;

      // Add item size
      const itemSize = document.createElement("div");
      itemSize.classList.add("text-sm", "text-gray-700");
      itemSize.innerText = `Size: ${item.size}`;

      // Add item quantity
      const itemQuantity = document.createElement("div");
      itemQuantity.classList.add("text-sm", "text-gray-700");
      itemQuantity.innerText = `Quantity: ${item.quantity}`;

      // Append item details to the itemDetails div
      itemDetails.appendChild(itemName);
      itemDetails.appendChild(itemPriceText);
      itemDetails.appendChild(itemSize);
      itemDetails.appendChild(itemQuantity);

      // Create a delete button with an icon
      const deleteButton = document.createElement("button");
      deleteButton.innerHTML = '<i class="fas fa-trash"></i>';
      deleteButton.value = JSON.stringify({ id: item.id, size: item.size });
      deleteButton.classList.add("bg-red-500", "hover:bg-red-600", "rounded-full", "text-white", "p-2", "ml-4", "transition", "duration-200");
      deleteButton.addEventListener("click", this.removeFromCart.bind(this)); // Bind `this` to the method

      // Append item details and delete button to the itemContainer
      itemContainer.appendChild(itemDetails);
      itemContainer.appendChild(deleteButton);

      // Append the itemContainer to the main cart element
      this.element.prepend(itemContainer);
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

    // Update the size field after the cart is processed
    this.updateSizeField(totalSize); // Replace 1/2 with actual size logic if necessary

    // Update the quantity field after the cart is processed
    this.updateQuantityField(totalQuantity); // Update quantity based on cart items

    // Update the item field after the cart is processed
    this.updateItemField(itemNames); // Update item names based on cart items
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
