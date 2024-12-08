import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = {
    id: Number,
    name: String,
    code: String,
    price: Number,
    size: String,
    unit: String,
    color_id: Number,
    product_id: Number,
  };

  connect() {
    this.selectedSize = null;
    this.selectedUnit = null;
    this.priceDisplay = document.getElementById("price-display"); // Reference to the price display element
    this.unitDisplay = document.getElementById("unit-display"); // Reference to the unit display element
    this.updatePrice(this.priceValue); // Set the default price
    this.updateUnit(this.unitValue); // Set the default unit

    // Initialize color and product IDs
    this.initializeIds();
  }

  initializeIds() {
    // Ensure color_idValue and product_idValue are defined
    if (this.colorIdValue == null || this.productIdValue == null) {
      console.error("Color ID or Product ID is missing");
      alert("An error occurred while initializing data. Please refresh the page.");
    } else {
      console.log("Color ID initialized:", this.colorIdValue);
      console.log("Product ID initialized:", this.productIdValue);
    }
  }

  getColorId() {
    return this.colorIdValue;
  }

  getProductId() {
    return this.productIdValue;
  }

  addToCart(event) {
    event.preventDefault(); // Prevent the default button behavior

    // Access data attributes from the clicked paint color element
    const paintColorElement = event.target.closest('.paint-color-card');
    const paintColorId = paintColorElement.dataset.paintColorId;
    const name = paintColorElement.dataset.paintColorName;
    const code = paintColorElement.dataset.paintColorCode;
    const price = paintColorElement.dataset.paintColorPrice;
    const colorId = paintColorElement.dataset.paintColorColorId;
    const productId = paintColorElement.dataset.paintColorProductId;
    const unitFromColor = paintColorElement.dataset.paintColorUnit; // Renamed to avoid conflict

    const size = this.selectedSizeTarget.dataset.size;
    const unitFromSize = this.selectedSizeTarget.dataset.unit; // Renamed to avoid conflict

    if (!size) {
      alert("Please select a size before adding to the cart.");
      return;
    }

    // Create a cart item
    const cartItem = {
      id: paintColorId,
      name: name,
      code: code,
      price: price,
      color_id: colorId,
      product_id: productId,
      size: size,
      unit: unitFromSize || unitFromColor, // Fallback to unitFromColor if unitFromSize is not available
      quantity: 1 // Default to 1 for now, you can add a quantity field later
    };

    // Get the existing cart from localStorage
    let cart = JSON.parse(localStorage.getItem("cart")) || [];

    // Add the new item to the cart
    cart.push(cartItem);

    // Save the updated cart back to localStorage
    localStorage.setItem("cart", JSON.stringify(cart));

    // Optionally, show a confirmation or update the cart UI
    alert(`${name} has been added to your cart.`);
}


  removeFromCart(event) {
    const cart = JSON.parse(localStorage.getItem("cart")) || [];
    const itemId = event.target.dataset.id;
    const itemSize = event.target.dataset.size;
    const itemUnit = event.target.dataset.unit;

    // Find the item in the cart
    const itemIndex = cart.findIndex(
      (cartItem) =>
        cartItem.id === parseInt(itemId) &&
        cartItem.size === itemSize &&
        cartItem.unit === itemUnit
    );

    if (itemIndex !== -1) {
      // Decrease quantity or remove item
      if (cart[itemIndex].quantity > 1) {
        cart[itemIndex].quantity -= 1;
      } else {
        cart.splice(itemIndex, 1); // Remove item if quantity is 1
      }
    }

    // Save updated cart back to localStorage
    localStorage.setItem("cart", JSON.stringify(cart));

    // Provide feedback to the user
    alert("Item removed from cart.");
  }

  selectSize(e) {
    this.sizeValue = e.target.value;
    const selectedPrice = e.target.dataset.price; // Get the price from the selected size option

    const selectedSizeEl = document.getElementById("selected-size");
    selectedSizeEl.innerText = `Selected Size: ${this.sizeValue}`;

    this.updatePrice(selectedPrice); // Update the price when a new size is selected
  }

  selectUnit(e) {
    this.unitValue = e.target.value;
    const selectedUnitEl = document.getElementById("selected-unit");
    selectedUnitEl.innerText = `Selected Unit: ${this.unitValue}`;

    // Filter the size options based on the selected unit
    const sizeSelect = document.getElementById("size-select");
    const sizeOptions = sizeSelect.querySelectorAll("option");

    sizeOptions.forEach((option) => {
      if (option.dataset.unit === this.unitValue || option.value === "") {
        option.style.display = "block"; // Show matching sizes
      } else {
        option.style.display = "none"; // Hide sizes that don't match the selected unit
      }
    });

    this.updateUnit(this.unitValue); // Update the unit when a new unit is selected
  }

  updatePrice(price) {
    // Update the price displayed on the page
    this.priceDisplay.innerHTML = `₱${parseFloat(price).toFixed(2)}`;
    this.priceValue = parseFloat(price); // Ensure the priceValue is updated
  }

  updateUnit(unit) {
    // Update the unit displayed on the page
    this.unitDisplay.innerHTML = `Unit: ${unit}`;
  }
}
