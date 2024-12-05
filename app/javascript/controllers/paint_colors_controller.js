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
    // Initialize cart in localStorage if it doesn't exist
    if (!localStorage.getItem("cart")) {
      localStorage.setItem("cart", JSON.stringify([]));
    }
  }

  addToCart() {
    const cart = JSON.parse(localStorage.getItem("cart")) || [];
    
    const item = {
      id: this.idValue,
      name: this.nameValue,
      code: this.codeValue,
      price: this.priceValue,
      size: this.sizeValue,
      unit: this.unitValue,
      color_id: this.color_idValue,
      product_id: this.product_idValue,
    };

    // Check if the item already exists in the cart
    const existingItemIndex = cart.findIndex(
      (cartItem) =>
        cartItem.id === item.id &&
        cartItem.size === item.size &&
        cartItem.unit === item.unit
    );

    if (existingItemIndex !== -1) {
      // If item exists, update quantity
      cart[existingItemIndex].quantity += 1;
    } else {
      // Otherwise, add as a new item
      item.quantity = 1;
      cart.push(item);
    }

    // Save updated cart back to localStorage
    localStorage.setItem("cart", JSON.stringify(cart));

    // Provide feedback to the user
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
}
