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

    // Retrieve the data from the controller's data attributes
    const paintColorId = this.data.get("id");
    const colorId = this.data.get("colorId");
    const productId = this.data.get("productId");
    const name = this.data.get("name");
    const code = this.data.get("code");
    const price = this.data.get("price");
    const size = this.selectedSizeTarget.dataset.size; // Get the selected size
    const unit = this.selectedSizeTarget.dataset.unit; // Get the selected size's unit

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
      unit: unit,
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



selectSize(event) {
  const size = event.target.value; // Get the selected size
  const price = event.target.getAttribute("data-price"); // Get the price
  const unit = event.target.getAttribute("data-unit"); // Get the unit (if needed)

  // Update the selected size display
  this.selectedSizeTarget.innerText = `Selected Size: ${size} (${unit})`;

  // Store selected size, price, and unit in the element's dataset for later use
  this.selectedSizeTarget.dataset.size = size;
  this.selectedSizeTarget.dataset.price = price;
  this.selectedSizeTarget.dataset.unit = unit;
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
