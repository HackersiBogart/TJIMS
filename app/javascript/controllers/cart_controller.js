import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="cart"
export default class extends Controller {
  initialize() {
    console.log("cart controller initialized")
    const cart = JSON.parse(localStorage.getItem("cart"))
    if (!cart) {
      return
    }

    let total = 0
    for (let i = 0; i < cart.length; i++) {
      const item = cart[i]
      const itemPrice = parseFloat(item.price) // Ensure price is a number
      total += itemPrice * item.quantity

      const div = document.createElement("div")
      div.classList.add("mt-2")
      div.innerText = `Item: ${item.name} - ₱${itemPrice.toFixed(2)} - Size: ${item.size} - Quantity: ${item.quantity}`

      const deleteButton = document.createElement("button")
      deleteButton.innerText = "Remove"
      console.log("item.id: ", item.id)
      deleteButton.value = JSON.stringify({ id: item.id, size: item.size })
      deleteButton.classList.add("bg-gray-500", "rounded", "text-white", "px-2", "py-1", "ml-2")
      deleteButton.addEventListener("click", this.removeFromCart)
      div.appendChild(deleteButton)
      this.element.prepend(div)
    }

    const totalEl = document.createElement("div")
    totalEl.innerText = `Total: ₱${total.toFixed(2)}` // Format the total to 2 decimal places
    let totalContainer = document.getElementById("total")
    totalContainer.appendChild(totalEl)
  }

  clear() {
    localStorage.removeItem("cart")
    window.location.reload()
  }

  removeFromCart(event) {
    const cart = JSON.parse(localStorage.getItem("cart"))
    const values = JSON.parse(event.target.value)
    const { id, size } = values
    const index = cart.findIndex(item => item.id === id && item.size === size)
    if (index >= 0) {
      cart.splice(index, 1)
    }
    localStorage.setItem("cart", JSON.stringify(cart))
    window.location.reload()
  }

  checkout(event) {
    event.preventDefault();
    window.location.href = "/checkouts/payment_options";
    const dateOfRetrieval = new Date().toISOString().split('T')[0]; // Get current date in YYYY-MM-DD format
    

  }
}
