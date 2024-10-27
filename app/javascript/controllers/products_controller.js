import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="product-controller"
export default class extends Controller {
  static values = { 
    id: Number, 
    name: String, 
    description: String, 
    active: Boolean, 
    color_id: Number, 
    color_name: String, 
    color_code: String, 
    image: String, 
    order_id: Number 
  }

  connect() {
    this.selectedActive = null
    this.colorNameDisplay = document.getElementById("color-name-display") // Reference to the color name display element
    this.descriptionDisplay = document.getElementById("description-display") // Reference to the description display element
    this.updateColorName(this.color_nameValue) // Set the default color name
    this.updateDescription(this.descriptionValue) // Set the default description
  }

  addToCart() {
    console.log("Product ID:", this.idValue)
    console.log("Product Name:", this.nameValue)
    console.log("Description:", this.descriptionValue)
    console.log("Active:", this.activeValue)
    console.log("Color ID:", this.color_idValue)
    console.log("Color Name:", this.color_nameValue)
    console.log("Color Code:", this.color_codeValue)
    console.log("Order ID:", this.order_idValue)

    const cart = localStorage.getItem("cart")
    let cartArray = cart ? JSON.parse(cart) : []

    const foundIndex = cartArray.findIndex(item => item.id === this.idValue && item.color_id === this.color_idValue && item.order_id === this.order_idValue)
    if (foundIndex >= 0) {
      // Update the quantity if the item already exists in the cart
      cartArray[foundIndex].quantity += 1
    } else {
      // Add new item to the cart
      cartArray.push({
        id: this.idValue,
        name: this.nameValue,
        description: this.descriptionValue,
        active: this.activeValue,
        color_id: this.color_idValue,
        color_name: this.color_nameValue,
        color_code: this.color_codeValue,
        image: this.imageValue,
        order_id: this.order_idValue,
        quantity: 1
      })
    }

    // Save the updated cart to localStorage
    localStorage.setItem("cart", JSON.stringify(cartArray))

    alert(`${this.nameValue} has been added to the cart!`)
  }

  updateColorName(colorName) {
    // Update the color name displayed on the page
    this.colorNameDisplay.innerHTML = `Color Name: ${colorName}`
  }

  updateDescription(description) {
    // Update the description displayed on the page
    this.descriptionDisplay.innerHTML = `Description: ${description}`
  }
}
