import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="paint-colors"
export default class extends Controller {
  static values = { 
    id: Number, 
    name: String, 
    code: String, 
    price: Number, 
    size: String, 
    unit: String, 
    colorName: String, 
    productName: String, 
  }

  connect() {
    this.selectedSize = null
    this.selectedUnit = null
    this.priceDisplay = document.getElementById("price-display") // Reference to the price display element
    this.unitDisplay = document.getElementById("unit-display")   // Reference to the unit display element
    this.updatePrice(this.priceValue) // Set the default price
    this.updateUnit(this.unitValue)   // Set the default unit
  }

  addToCart() {
    console.log("Paint Color ID:", this.idValue)
    console.log("Paint Color Name:", this.nameValue)
    console.log("Paint Color Code:", this.codeValue)
    console.log("Paint Color Price:", this.priceValue)
    console.log("Brand:", this.colorNameValue); // Should not be undefined
    console.log("Product:", this.productNameValue); // Should not be undefined


    const cart = localStorage.getItem("cart")
    let cartArray = cart ? JSON.parse(cart) : []

    const foundIndex = cartArray.findIndex(item => item.id === this.idValue && item.size === this.sizeValue && item.unit === this.unitValue
      && item.color.name=== this.colorNameValue && item.product.name === this.productNameValue
     )
    if (foundIndex >= 0) {
      // Update the quantity if the item already exists in the cart
      cartArray[foundIndex].quantity += 1
    } else {
      // Add new item to the cart
      cartArray.push({
        id: this.idValue,
      name: this.nameValue,
      code: this.codeValue,
      size: this.sizeValue,
      price: this.priceValue,
      unit: this.unitValue,
      quantity: 1,
      colorName:  this.colorNameValue,
      productName: this.productNameValue

      })
    }

    // Save the updated cart to localStorage
    localStorage.setItem("cart", JSON.stringify(cartArray))

    alert(`${this.nameValue} has been added to the cart!`)
  }

  selectSize(e) {
    this.sizeValue = e.target.value
    const selectedPrice = e.target.dataset.price // Get the price from the selected size option

    const selectedSizeEl = document.getElementById("selected-size")
    selectedSizeEl.innerText = `Selected Size: ${this.sizeValue}`

    this.updatePrice(selectedPrice) // Update the price when a new size is selected
  }

  selectUnit(e) {
    this.unitValue = e.target.value
    const selectedUnitEl = document.getElementById("selected-unit")
    selectedUnitEl.innerText = `Selected Unit: ${this.unitValue}`

    // Filter the size options based on the selected unit
    const sizeSelect = document.getElementById("size-select")
    const sizeOptions = sizeSelect.querySelectorAll("option")

    sizeOptions.forEach(option => {
      if (option.dataset.unit === this.unitValue || option.value === "") {
        option.style.display = "block" // Show matching sizes
      } else {
        option.style.display = "none" // Hide sizes that don't match the selected unit
      }
    })

    this.updateUnit(this.unitValue) // Update the unit when a new unit is selected
  }

  updatePrice(price) {
    // Update the price displayed on the page
    this.priceDisplay.innerHTML = `₱${parseFloat(price).toFixed(2)}`
    this.priceValue = parseFloat(price) // Ensure the priceValue is updated
  }

  updateUnit(unit) {
    // Update the unit displayed on the page
    this.unitDisplay.innerHTML = `Unit: ${unit}`
  }
}


