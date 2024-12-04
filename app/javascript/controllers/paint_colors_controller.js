import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { 
    id: Number, 
    name: String, 
    code: String, 
    price: Number, 
    colorId: Number, 
    colorName: String, 
    productId: Number, 
    productName: String 
  }

  static targets = ["selectedSize", "priceDisplay"]

  addToCart() {
    // Validate size selection
    if (!this.hasSelectedSize) {
      alert("Please select a size before adding to cart")
      return
    }

    // Retrieve existing cart or initialize
    const cart = JSON.parse(localStorage.getItem("cart") || "[]")

    // Check if item already exists in cart
    const existingItemIndex = cart.findIndex(
      item => item.id === this.idValue && 
              item.size === this.selectedSize
    )

    if (existingItemIndex > -1) {
      // Increment quantity if item exists
      cart[existingItemIndex].quantity += 1
    } else {
      // Add new item to cart
      cart.push({
        id: this.idValue,
        name: this.nameValue,
        code: this.codeValue,
        size: this.selectedSize,
        price: this.priceValue,
        quantity: 1,
        color: { 
          id: this.colorIdValue, 
          name: this.colorNameValue 
        },
        product: { 
          id: this.productIdValue, 
          name: this.productNameValue 
        }
      })
    }

    // Save updated cart
    localStorage.setItem("cart", JSON.stringify(cart))
    
    // Notify user
    alert(`${this.nameValue} added to cart!`)
  }

  selectSize(event) {
    // Store selected size
    this.selectedSize = event.target.value
    
    // Update selected size display
    this.selectedSizeTarget.textContent = `Selected Size: ${this.selectedSize}`
  }
}