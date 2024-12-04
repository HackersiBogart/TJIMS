import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { 
    id: Number, 
    name: String, 
    code: String, 
    price: Number, 
    size: String, 
    unit: String, 
    colorId: Number, 
    colorName: String, 
    productId: Number, 
    productName: String 
  }

  static targets = ["selectedSize", "unitDisplay", "priceDisplay"]

  connect() {
    this.selectedSize = null
    this.selectedUnit = null
    
    // Safely check and update price display
    if (this.hasPriceDisplayTarget) {
      this.updatePrice(this.priceValue)
    }
    
    // Safely check and update unit display
    if (this.hasUnitDisplayTarget) {
      this.updateUnit(this.unitValue)
    }
  }

  addToCart() {
    // Ensure size and unit are selected before adding to cart
    if (!this.sizeValue || !this.unitValue) {
      alert("Please select a size and unit before adding to cart.")
      return
    }

    const cart = localStorage.getItem("cart")
    let cartArray = cart ? JSON.parse(cart) : []

    const foundIndex = cartArray.findIndex(
      item => item.id === this.idValue && 
             item.size === this.sizeValue && 
             item.unit === this.unitValue
    )

    if (foundIndex >= 0) {
      cartArray[foundIndex].quantity += 1
    } else {
      cartArray.push({
        id: this.idValue,
        name: this.nameValue,
        code: this.codeValue,
        size: this.sizeValue,
        price: this.priceValue,
        unit: this.unitValue,
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

    localStorage.setItem("cart", JSON.stringify(cartArray))
    alert(`${this.nameValue} has been added to the cart!`)
  }

  selectSize(e) {
    this.sizeValue = e.target.value
    const selectedPrice = e.target.dataset.price

    if (this.hasSelectedSizeTarget) {
      this.selectedSizeTarget.innerText = `Selected Size: ${this.sizeValue}`
    }

    this.updatePrice(selectedPrice)
  }

  updatePrice(price) {
    if (this.hasPriceDisplayTarget) {
      this.priceDisplayTarget.innerHTML = `₱${parseFloat(price).toFixed(2)}`
      this.priceValue = parseFloat(price)
    }
  }

  updateUnit(unit) {
    if (this.hasUnitDisplayTarget) {
      this.unitDisplayTarget.innerHTML = `Unit: ${unit}`
    }
  }
}