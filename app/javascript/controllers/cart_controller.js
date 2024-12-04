import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  initialize() {
    this.updateCartDisplay()
  }

  updateCartDisplay() {
    const cart = JSON.parse(localStorage.getItem("cart") || "[]")
    
    // Clear existing cart items
    this.element.innerHTML = ''
    
    let total = 0
    let itemNames = []

    cart.forEach(item => {
      total += item.price * item.quantity
      itemNames.push(item.name)

      // Create cart item element
      const cartItemElement = document.createElement('div')
      cartItemElement.classList.add('bg-gray-100', 'p-4', 'mb-2', 'rounded')
      cartItemElement.innerHTML = `
        <div>
          <p>Product: ${item.product.name}</p>
          <p>Color: ${item.color.name}</p>
          <p>Paint: ${item.name}</p>
          <p>Size: ${item.size}</p>
          <p>Price: ₱${item.price.toFixed(2)}</p>
          <p>Quantity: ${item.quantity}</p>
        </div>
      `

      this.element.appendChild(cartItemElement)
    })

    // Update total
    const totalElement = document.getElementById('total')
    if (totalElement) {
      totalElement.textContent = `Total: ₱${total.toFixed(2)}`
    }
  }

  clearCart() {
    localStorage.removeItem("cart")
    this.updateCartDisplay()
  }
}