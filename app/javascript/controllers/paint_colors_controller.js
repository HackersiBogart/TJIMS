import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="paint-colors"
export default class extends Controller {
  static targets = ["size", "unit"];

  initialize() {
    console.log("PaintColor controller initialized");
    this.updateSizeOptions();
  }

  addToCart(event) {
    event.preventDefault();

    const selectedSize = this.sizeTarget.value;
    const selectedUnit = this.unitTarget.value;
    const paintColorId = this.element.dataset.paintColorId;
    const paintColorName = this.element.dataset.paintColorName;
    const paintColorPrice = parseFloat(this.element.dataset.paintColorPrice);
    const productName = this.element.dataset.productName;
    const colorName = this.element.dataset.colorName;

    const quantityInput = document.querySelector(
      `#quantity-input-${paintColorId}`
    );
    const quantity = parseInt(quantityInput.value, 10) || 1;

    if (!selectedSize || !selectedUnit) {
      alert("Please select a size and unit before adding to the cart.");
      return;
    }

    const cart = JSON.parse(localStorage.getItem("cart")) || [];
    const existingItemIndex = cart.findIndex(
      (item) =>
        item.id === paintColorId &&
        item.size === selectedSize &&
        item.unit === selectedUnit
    );

    if (existingItemIndex !== -1) {
      // Update the quantity of the existing item
      cart[existingItemIndex].quantity += quantity;
    } else {
      // Add a new item to the cart
      cart.push({
        id: paintColorId,
        name: paintColorName,
        size: selectedSize,
        unit: selectedUnit,
        price: paintColorPrice,
        quantity: quantity,
        product_name: productName,
        color_name: colorName,
      });
    }

    localStorage.setItem("cart", JSON.stringify(cart));
    alert(`${paintColorName} has been added to the cart!`);
  }

  updateSizeOptions() {
    const selectedUnit = this.unitTarget.value;
    const sizeOptions = this.sizeTarget.querySelectorAll("option");

    sizeOptions.forEach((option) => {
      if (option.dataset.unit === selectedUnit || option.value === "") {
        option.hidden = false;
      } else {
        option.hidden = true;
      }
    });

    // Reset the size dropdown to default
    this.sizeTarget.value = "";
  }

  calculateTotal() {
    const selectedSize = this.sizeTarget.value;
    const paintColorPrice = parseFloat(this.element.dataset.paintColorPrice);
    const quantityInput = document.querySelector(
      `#quantity-input-${this.element.dataset.paintColorId}`
    );
    const quantity = parseInt(quantityInput.value, 10) || 1;

    if (!selectedSize || isNaN(paintColorPrice)) {
      alert("Please select a size before calculating the total.");
      return;
    }

    const total = paintColorPrice * quantity;
    const totalDisplay = document.getElementById("total-display");

    if (totalDisplay) {
      totalDisplay.innerText = `₱${total.toFixed(2)}`;
    } else {
      console.error("Total display element not found.");
    }
  }
}
