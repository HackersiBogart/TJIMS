import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="paint-colors"
export default class extends Controller {
  static values = { id: Number, name: String, code: String, price: Number, size: String }

  addToCart() {
    console.log("Paint Color ID:", this.idValue);
    console.log("Paint Color Name:", this.nameValue);
    console.log("Paint Color Code:", this.codeValue);
    console.log("Paint Color Price:", this.priceValue);

    const cart = localStorage.getItem("cart")
    let cartArray = cart ? JSON.parse(cart) : []

    const foundIndex = cartArray.findIndex(item => item.id === this.idValue && item.size === this.sizeValue)
    if (foundIndex >= 0) {
      cartArray[foundIndex].quantity += 1
    } else {
      cartArray.push({
        id: this.idValue,           // Correctly access the value without the .id
        name: this.nameValue,       // Correctly access the value without the .name
        code: this.codeValue,       // Correctly access the value without the .code
        size: this.sizeValue,
        price: this.priceValue,
        quantity: 1
      })
    }

    localStorage.setItem("cart", JSON.stringify(cartArray))
  }

  selectSize(e) {
    this.sizeValue = e.target.value
    const selectedSizeEl = document.getElementById("selected-size")
    selectedSizeEl.innerText = `Selected Size: ${this.sizeValue}`
  }
}
