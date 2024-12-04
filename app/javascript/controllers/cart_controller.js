import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  initialize() {
    console.log("Cart controller initializing...");
    this.verifyLocalStorageSupport();
    this.updateTotal();
  }

  // Check localStorage support
  verifyLocalStorageSupport() {
    try {
      localStorage.setItem('test', 'test');
      localStorage.removeItem('test');
    } catch (e) {
      console.error("LocalStorage is not available:", e);
      this.showError("Browser storage is disabled. Cart functionality may be limited.");
    }
  }

  // Display error messages
  showError(message) {
    const errorContainer = document.getElementById('errorContainer');
    if (errorContainer) {
      errorContainer.textContent = message;
      errorContainer.style.display = 'block';
    }
  }

  updateTotal() {
    console.log("Updating cart total...");
    
    // Get cart items container
    const cartItemsContainer = this.element.querySelector("#cartItems");
    if (!cartItemsContainer) {
      console.error("Cart items container not found");
      this.showError("Unable to display cart items");
      return;
    }

    // Clear previous cart items
    cartItemsContainer.innerHTML = '';

    // Retrieve cart from localStorage
    const cart = JSON.parse(localStorage.getItem("cart")) || [];
    console.log("Cart items:", cart);

    // Handle empty cart
    if (cart.length === 0) {
      cartItemsContainer.innerHTML = `
        <div class="text-center text-gray-500 py-4">
          Your cart is empty. Start shopping to add items!
        </div>
      `;
      this.resetTotalDisplay();
      return;
    }

    let total = 0;
    let totalQuantity = 0;
    let totalSize = [];
    let itemNames = [];
    let itemColors = [];
    let itemProducts = [];

    // Process each cart item
    cart.forEach((item, index) => {
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

      // Create cart item element
      const itemContainer = this.createCartItemElement(item, {
        name: itemName,
        price: itemPrice,
        quantity: itemQuantity,
        size: itemSize,
        colorId: itemColorId,
        productId: itemProductId
      });

      // Append to cart items container
      cartItemsContainer.appendChild(itemContainer);
    });

    // Update total and other order fields
    this.updateOrderFields(total, totalQuantity, totalSize, itemNames, itemColors, itemProducts);
  }

  createCartItemElement(item, details) {
    const itemContainer = document.createElement("div");
    itemContainer.classList.add("flex", "justify-between", "items-center", "bg-gray-100", "rounded-lg", "p-4", "mt-2", "shadow-md");

    const itemDetails = document.createElement("div");
    itemDetails.classList.add("flex", "flex-col", "gap-1");

    // Populate item details
    const detailsToShow = [
      { label: "Product ID", value: details.productId },
      { label: "Color", value: details.colorId },
      { label: "Item", value: details.name, className: "font-semibold text-lg text-[#1E3E62]" },
      { label: "Price", value: `₱${details.price.toFixed(2)}` },
      { label: "Size", value: details.size },
      { label: "Quantity", value: details.quantity }
    ];

    detailsToShow.forEach(detail => {
      const detailElement = document.createElement("div");
      detailElement.classList.add("text-sm", "text-gray-700");
      if (detail.className) {
        detailElement.classList.add(...detail.className.split(" "));
      }
      detailElement.innerText = `${detail.label}: ${detail.value}`;
      itemDetails.appendChild(detailElement);
    });

    // Create delete button
    const deleteButton = document.createElement("button");
    deleteButton.innerHTML = '<i class="fas fa-trash"></i>';
    deleteButton.value = JSON.stringify({ id: item.id, size: item.size });
    deleteButton.classList.add("bg-red-500", "hover:bg-red-600", "rounded-full", "text-white", "p-2", "ml-4", "transition", "duration-200");
    deleteButton.addEventListener("click", this.removeFromCart.bind(this));

    // Assemble item container
    itemContainer.appendChild(itemDetails);
    itemContainer.appendChild(deleteButton);

    return itemContainer;
  }

  updateOrderFields(total, totalQuantity, totalSize, itemNames, itemColors, itemProducts) {
    // Update total display
    this.safeUpdateField("total", `Total: ₱${total.toFixed(2)}`);
    
    // Update hidden input fields for order submission
    this.safeUpdateField("order_total", `₱${total.toFixed(2)}`);
    this.safeUpdateField("order_size", totalSize.join(', ')); 
    this.safeUpdateField("order_quantity", totalQuantity);
    this.safeUpdateField("order_items", itemNames.join(", "));
    this.safeUpdateField("order_colors", itemColors.join(", "));
    this.safeUpdateField("order_products", itemProducts.join(", "));
  }

  // Flexible method to update any field safely
  safeUpdateField(fieldId, value) {
    const field = document.querySelector(`#${fieldId}, [data-field="${fieldId}"]`);
    
    if (field) {
      if (field.tagName === 'INPUT' || field.tagName === 'TEXTAREA') {
        field.value = value;
      } else {
        field.textContent = value;
      }
    } else {
      console.warn(`Field with ID or data-field "${fieldId}" not found`);
    }
  }

  // Reset total display when cart is empty
  resetTotalDisplay() {
    this.safeUpdateField("total", "Total: ₱0.00");
    this.safeUpdateField("order_total", "₱0.00");
  }

  // Clear entire cart
  clear() {
    localStorage.removeItem("cart");
    this.updateTotal(); // Refresh the view
  }

  // Remove single item from cart
  removeFromCart(event) {
    const cart = JSON.parse(localStorage.getItem("cart")) || [];
    const values = JSON.parse(event.target.value);
    const { id, size } = values;
    
    const updatedCart = cart.filter(item => !(item.id === id && item.size === size));
    
    localStorage.setItem("cart", JSON.stringify(updatedCart));
    this.updateTotal(); // Refresh the view
  }

  // Navigate to checkout
  checkout(event) {
    event.preventDefault();
    
    const cart = JSON.parse(localStorage.getItem("cart")) || [];
    if (cart.length === 0) {
      alert("Your cart is empty. Please add items before checkout.");
      return;
    }
    
    window.location.href = "/customer_orders/new";
  }
}