import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="paint-colors"
export default class extends Controller {
  static values = { id: Number, name: String, code: String, price: Number, size: String, unit: String, color_id: Number, product_id: Number }

  connect() {
    this.selectedSize = this.sizeValue || null;
    this.selectedUnit = this.unitValue || null;
    this.priceDisplay = document.getElementById("price-display");
    this.unitDisplay = document.getElementById("unit-display");

    this.updatePrice(this.priceValue); // Set the default price
    this.updateUnit(this.unitValue);   // Set the default unit
  }

  addToCart() {
    const cart = JSON.parse(localStorage.getItem("cart")) || [];

    const foundIndex = cart.findIndex(item => 
      item.id === this.idValue &&
      item.size === this.sizeValue &&
      item.unit === this.unitValue &&
      item.color_id === this.color_idValue &&
      item.product_id === this.product_idValue
    );

    if (foundIndex >= 0) {
      // Update the quantity if the item exists in the cart
      cart[foundIndex].quantity += 1;
    } else {
      // Add a new item to the cart
      cart.push({
        id: this.idValue,
        name: this.nameValue,
        code: this.codeValue,
        size: this.sizeValue,
        price: this.priceValue,
        unit: this.unitValue,
        quantity: 1,
        color_id: this.color_idValue,
        product_id: this.product_idValue
      });
    }

    // Save the updated cart to localStorage
    localStorage.setItem("cart", JSON.stringify(cart));
    alert(`${this.nameValue} has been added to the cart!`);
  }

  selectSize(event) {
    this.sizeValue = event.target.value;
    const selectedPrice = parseFloat(event.target.dataset.price);

    const selectedSizeEl = document.getElementById("selected-size");
    selectedSizeEl.innerText = `Selected Size: ${this.sizeValue}`;

    this.updatePrice(selectedPrice); // Update displayed price
  }

  selectUnit(event) {
    this.unitValue = event.target.value;

    const selectedUnitEl = document.getElementById("selected-unit");
    selectedUnitEl.innerText = `Selected Unit: ${this.unitValue}`;

    // Filter size options based on selected unit
    const sizeSelect = document.getElementById("size-select");
    const sizeOptions = sizeSelect.querySelectorAll("option");

    sizeOptions.forEach(option => {
      if (option.dataset.unit === this.unitValue || option.value === "") {
        option.style.display = "block";
      } else {
        option.style.display = "none";
      }
    });

    this.updateUnit(this.unitValue);
  }

  updatePrice(price) {
    if (this.priceDisplay) {
      this.priceDisplay.innerHTML = `₱${parseFloat(price).toFixed(2)}`;
    }
    this.priceValue = parseFloat(price);
  }

  updateUnit(unit) {
    if (this.unitDisplay) {
      this.unitDisplay.innerHTML = `Unit: ${unit}`;
    }
  }
}
