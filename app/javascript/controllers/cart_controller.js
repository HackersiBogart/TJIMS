import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="cart"
export default class extends Controller {
  initialize() {
    console.log("cart controller initialized");
    this.updateTotal();
  }

  updateTotal() {
    const cart = JSON.parse(localStorage.getItem("cart")) || [];
    console.log("Cart from localStorage:", cart);
    console.log({
      paint_color_ids: paintColorIds,
      color_ids: colorIds,
      product_ids: productIds
    });

    let total = 0;
    
    // Clear only the cart items container
    const cartItemsContainer = document.getElementById("cartItems");
    if (cartItemsContainer) {
      cartItemsContainer.innerHTML = "";
    }
  
    for (let i = 0; i < cart.length; i++) {
      const item = cart[i];
      const itemPrice = parseFloat(item.price);
      total += itemPrice * item.quantity;

    
      // Create the cart item UI
      const itemContainer = document.createElement("div");
      itemContainer.classList.add(
        "flex",
        "justify-between",
        "items-center",
        "bg-gray-100",
        "rounded-lg",
        "p-4",
        "mt-2",
        "shadow-md"
      );
    
      const itemDetails = document.createElement("div");
      itemDetails.classList.add("flex", "flex-col", "gap-1");
    
      const itemName = document.createElement("div");
      itemName.classList.add("font-semibold", "text-lg", "text-[#1E3E62]");
      itemName.innerText = `Item: ${item.name}`;
    
      const itemProduct = document.createElement("div");  // Add product display
      itemProduct.classList.add("text-sm", "text-gray-700");
      itemProduct.innerText = `Product: ${item.product}`;
    
      const itemColor = document.createElement("div");  // Add color display
      itemColor.classList.add("text-sm", "text-gray-700");
      itemColor.innerText = `Brand: ${item.color}`;
    
      const itemPriceText = document.createElement("div");
      itemPriceText.classList.add("text-sm", "text-gray-700");
      itemPriceText.innerText = `Price: ₱${itemPrice.toFixed(2)}`;
    
      const itemQuantity = document.createElement("div");
      itemQuantity.classList.add("text-sm", "text-gray-700");
      itemQuantity.innerText = `Quantity: ${item.quantity}`;

      const itemSize = document.createElement("div");
      itemSize.classList.add("text-sm", "text-gray-700");
      itemSize.innerText = `Size: ${item.size}`;
    
      itemDetails.appendChild(itemName);
      itemDetails.appendChild(itemProduct);  // Append product
      itemDetails.appendChild(itemColor);    // Append color
      itemDetails.appendChild(itemPriceText);
      itemDetails.appendChild(itemQuantity);
      itemDetails.appendChild(itemSize);
    
      const deleteButton = document.createElement("button");
      deleteButton.innerHTML = '<i class="fas fa-trash"></i>';
      deleteButton.value = JSON.stringify({ id: item.id, size: item.size });
      deleteButton.classList.add(
        "bg-red-500",
        "hover:bg-red-600",
        "rounded-full",
        "text-white",
        "p-2",
        "ml-4",
        "transition",
        "duration-200"
      );
      deleteButton.addEventListener("click", this.removeFromCart.bind(this));
    
      itemContainer.appendChild(itemDetails);
      itemContainer.appendChild(deleteButton);
    
      if (cartItemsContainer) {
        cartItemsContainer.prepend(itemContainer);
      }
    }
    
    const totalDiv = document.getElementById("total");
    if (totalDiv) {
      totalDiv.innerText = `Total: ₱${total.toFixed(2)}`;
    }
  }
  
  

  updateSizeField(size) {
    const sizeField = document.getElementById("order_size");
    if (sizeField) {
      sizeField.value = `${size}`; // Update size field value
    } else {
      console.error("Size field not found");
    }
  }

  updateQuantityField(quantity) {
    const quantityField = document.getElementById("order_quantity");
    if (quantityField) {
      quantityField.value = quantity; // Update quantity field value
    } else {
      console.error("Quantity field not found");
    }
  }

  updateItemField(items) {
    const itemField = document.getElementById("order_items");
    if (itemField) {
      itemField.value = items.join(", "); // Join item names into a single string
    } else {
      console.error("Item field not found");
    }
  }

  clear() {
    localStorage.removeItem("cart");
    window.location.reload();
  }

  removeFromCart(event) {
    const cart = JSON.parse(localStorage.getItem("cart"));
    const values = JSON.parse(event.target.value);
    const { id, size } = values;
    const index = cart.findIndex(item => item.id === id && item.size === size);
    if (index >= 0) {
      cart.splice(index, 1);
      localStorage.setItem("cart", JSON.stringify(cart));
      window.location.reload();
    }
  }

  checkout(event) {
    event.preventDefault();
    window.location.href = "/customer_orders/new";
  }
}
