import { Controller } from "@hotwired/stimulus"

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
    let totalSize = [];
    let itemNames = [];
    let itemColors = [];
    let itemProducts = [];

    // Clear previous cart items
    this.element.innerHTML = '';

    // Calculate total, quantity, and collect item details
    for (let i = 0; i < cart.length; i++) {
      const item = cart[i];

      // Debugging: Log full item details
      console.log("Cart Item Details:", item);

      // Ensure all required properties exist with fallback values
      const itemName = item.name || 'Unnamed Item';
      const itemPrice = parseFloat(item.price) || 0; 
      const itemQuantity = item.quantity || 1;
      const itemSize = item.size || 'N/A';
      const itemColorId = item.color_id || 'No Color';
      const itemProductId = item.product_id || 'No Product ID';

      // Calculations
      total += itemPrice * itemQuantity;
      totalQuantity += itemQuantity;
      totalSize.push(itemSize);
      itemNames.push(itemName);
      itemColors.push(itemColorId);
      itemProducts.push(itemProductId);

      // Create a container div for the cart item
      const itemContainer = document.createElement("div");
      itemContainer.classList.add("flex", "justify-between", "items-center", "bg-gray-100", "rounded-lg", "p-4", "mt-2", "shadow-md");

      // Create a div for the item details
      const itemDetails = document.createElement("div");
      itemDetails.classList.add("flex", "flex-col", "gap-1");

      // Add product name with fallback
      const productName = document.createElement("div");
      productName.classList.add("text-sm", "text-gray-700");
      productName.innerText = `Product ID: ${itemProductId}`;

      // Add color name with fallback
      const colorName = document.createElement("div");
      colorName.classList.add("text-sm", "text-gray-700");
      colorName.innerText = `Color: ${itemColorId}`;

      // Add item name
      const itemNameElement = document.createElement("div");
      itemNameElement.classList.add("font-semibold", "text-lg", "text-[#1E3E62]");
      itemNameElement.innerText = `Item: ${itemName}`;

      // Add item price
      const itemPriceText = document.createElement("div");
      itemPriceText.classList.add("text-sm", "text-gray-700");
      itemPriceText.innerText = `Price: ₱${itemPrice.toFixed(2)}`;

      // Add item size
      const itemSizeElement = document.createElement("div");
      itemSizeElement.classList.add("text-sm", "text-gray-700");
      itemSizeElement.innerText = `Size: ${itemSize}`;

      // Add item quantity
      const itemQuantityElement = document.createElement("div");
      itemQuantityElement.classList.add("text-sm", "text-gray-700");
      itemQuantityElement.innerText = `Quantity: ${itemQuantity}`;

      // Append item details to the itemDetails div
      itemDetails.appendChild(productName);
      itemDetails.appendChild(colorName);
      itemDetails.appendChild(itemNameElement);
      itemDetails.appendChild(itemPriceText);
      itemDetails.appendChild(itemSizeElement);
      itemDetails.appendChild(itemQuantityElement);

      // Create a delete button with an icon
      const deleteButton = document.createElement("button");
      deleteButton.innerHTML = '<i class="fas fa-trash"></i>';
      deleteButton.value = JSON.stringify({ id: item.id, size: item.size });
      deleteButton.classList.add("bg-red-500", "hover:bg-red-600", "rounded-full", "text-white", "p-2", "ml-4", "transition", "duration-200");
      deleteButton.addEventListener("click", this.removeFromCart.bind(this));

      // Append item details and delete button to the itemContainer
      itemContainer.appendChild(itemDetails);
      itemContainer.appendChild(deleteButton);

      // Append the itemContainer to the main cart element
      this.element.prepend(itemContainer);
    }

    // Update the total in the div
    const totalDiv = document.getElementById("total");
    if (totalDiv) {
      totalDiv.innerText = `Total: ₱${total.toFixed(2)}`; 
    } else {
      console.error("Total div not found");
    }

    // Update the total in the text field
    const totalField = document.getElementById("order_total");
    if (totalField) {
      totalField.value = `₱${total.toFixed(2)}`; 
    } else {
      console.error("Total field not found");
    }

    // Update fields with fallback to empty array if needed
    this.updateSizeField(totalSize.join(', ')); 
    this.updateQuantityField(totalQuantity);
    this.updateItemField(itemNames, "order_items");
    this.updateItemField(itemColors, "order_colors");
    this.updateItemField(itemProducts, "order_products");
  }

  updateSizeField(size) {
    const sizeField = document.getElementById("order_size");
    if (sizeField) {
      sizeField.value = size || ''; 
    } else {
      console.error("Size field not found");
    }
  }

  updateQuantityField(quantity) {
    const quantityField = document.getElementById("order_quantity");
    if (quantityField) {
      quantityField.value = quantity || 0; 
    } else {
      console.error("Quantity field not found");
    }
  }

  updateItemField(items, fieldId) {
    const itemField = document.getElementById(fieldId);
    if (itemField) {
      itemField.value = items.join(", "); 
    } else {
      console.error(`${fieldId} field not found`);
    }
  }
 
  clear() {
    localStorage.removeItem("cart");
    window.location.reload();
  }

  removeFromCart(event) {
    const cart = JSON.parse(localStorage.getItem("cart")) || [];
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