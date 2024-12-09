import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = {
    id: Number,
    name: String,
    code: String,
    price: Number,
    size: String,
    unit: String,
    color: String,      // Add this for color
    product: String,    // Add this for product
  };

  connect() {
    this.selectedSize = null;
    this.selectedUnit = null;
    this.priceDisplay = document.getElementById("price-display"); // Reference to the price display element
    this.unitDisplay = document.getElementById("unit-display"); // Reference to the unit display element
    this.updatePrice(this.priceValue); // Set the default price
    this.updateUnit(this.unitValue); // Set the default unit

    console.log("Color value:", this.colorValue);  // This should print the color
    console.log("Product value:", this.productValue);  // This should print the product

  }

  addToCart() {
    console.log("Adding to cart...");

  
    const cart = JSON.parse(localStorage.getItem("cart")) || [];
  
    const item = {
      id: this.idValue,
      name: this.nameValue,
      code: this.codeValue,
      price: this.priceValue,
      size: this.sizeValue,
      unit: this.unitValue,
      color: this.colorValue,      // Pass the color value
      product: this.productValue,  // Pass the product value
    };
  
    console.log("Item to be added:", item);
  
    // Add item to cart
    const existingItemIndex = cart.findIndex(cartItem => 
      cartItem.id === item.id && cartItem.size === item.size && cartItem.unit === item.unit
    );
  
    if (existingItemIndex !== -1) {
      cart[existingItemIndex].quantity += 1;
    } else {
      item.quantity = 1;
      cart.push(item);
    }
  
    localStorage.setItem("cart", JSON.stringify(cart));
    alert(`${item.name} (${item.size} ${item.unit}) added to cart!`);
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
