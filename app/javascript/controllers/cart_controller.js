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
    const totalDiv = document.querySelector("#total, [data-total-display]");
    if (totalDiv) {
      totalDiv.textContent = `Total: ₱${total.toFixed(2)}`; 
    } else {
      console.warn("Total display element not found");
    }

    // Update the total in the text field
    const totalField = document.querySelector("#order_total, [data-total-input]");
    if (totalField) {
      totalField.value = `₱${total.toFixed(2)}`; 
    } else {
      console.warn("Total input element not found");
    }

    // Update fields with fallback to empty array if needed
    this.safeUpdateField("order_size", totalSize.join(', ')); 
    this.safeUpdateField("order_quantity", totalQuantity);
    this.safeUpdateField("order_items", itemNames.join(", "));
    this.safeUpdateField("order_colors", itemColors.join(", "));
    this.safeUpdateField("order_products", itemProducts.join(", "));
  }

  // Flexible method to update any field safely
  safeUpdateField(fieldId, value) {
    // Try to find the field by ID or data attribute
    const field = document.querySelector(`#${fieldId}, [data-field="${fieldId}"]`);
    
    if (field) {
      // If it's an input or textarea, set value
      if (field.tagName === 'INPUT' || field.tagName === 'TEXTAREA') {
        field.value = value;
      } 
      // If it's any other element, set textContent
      else {
        field.textContent = value;
      }
    } else {
      // Only log if the field is completely missing
      console.warn(`Field with ID or data-field "${fieldId}" not found`);
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