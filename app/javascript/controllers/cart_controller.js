import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="cart"
export default class extends Controller {
  initialize() {
    console.log("cart controller initialized");
    this.updateTotal();
  }

  updateTotal() {
    let cart = [];
    try {
      cart = JSON.parse(localStorage.getItem("cart") || '[]');
    } catch (error) {
      console.error("Invalid cart data", error);
      localStorage.removeItem("cart");
    }

    let total = 0;
    let totalQuantity = 0;
    let totalSize = 0;
    const itemNames = [];
    const itemColors = [];
    const itemProducts = [];

    // Create a document fragment for better performance
    const fragment = document.createDocumentFragment();

    // Calculate total, quantity, and collect item details
    for (const item of cart) {
      const itemPrice = parseFloat(item.price) || 0; // Ensure price is a number
      total += itemPrice * (item.quantity || 1);
      totalQuantity += parseInt(item.quantity) || 1;
      totalSize += parseInt(item.size) || 0;
      
      itemNames.push(item.name);
      itemColors.push(item.color_id);
      itemProducts.push(item.product_id);

      // Create a container div for the cart item
      const itemContainer = document.createElement("div");
      itemContainer.classList.add("flex", "justify-between", "items-center", "bg-gray-100", "rounded-lg", "p-4", "mt-2", "shadow-md");

      // Create a div for the item details
      const itemDetails = document.createElement("div");
      itemDetails.classList.add("flex", "flex-col", "gap-1");

      // Create detail elements with error handling
      const createDetailElement = (text, className = "text-sm text-gray-700") => {
        const element = document.createElement("div");
        element.classList.add(...className.split(" "));
        element.innerText = text;
        return element;
      };

      // Append detail elements
      [
        `Product: ${item.product_id}`,
        `Color: ${item.color_id}`,
        {text: `Item: ${item.name}`, className: "font-semibold text-lg text-[#1E3E62]"},
        `Price: ₱${itemPrice.toFixed(2)}`,
        `Size: ${item.size}`,
        `Quantity: ${item.quantity}`
      ].forEach(detail => {
        const element = typeof detail === 'string' 
          ? createDetailElement(detail)
          : createDetailElement(detail.text, detail.className);
        itemDetails.appendChild(element);
      });

      // Create a delete button with an icon
      const deleteButton = document.createElement("button");
      deleteButton.innerHTML = '<i class="fas fa-trash"></i>';
      deleteButton.value = JSON.stringify({ id: item.id, size: item.size });
      deleteButton.classList.add("bg-red-500", "hover:bg-red-600", "rounded-full", "text-white", "p-2", "ml-4", "transition", "duration-200");
      deleteButton.addEventListener("click", (event) => this.removeFromCart(event)); 

      // Append item details and delete button to the itemContainer
      itemContainer.appendChild(itemDetails);
      itemContainer.appendChild(deleteButton);

      // Add to fragment instead of directly to element
      fragment.appendChild(itemContainer);
    }

    // Clear existing content and prepend fragment
    this.element.innerHTML = '';
    this.element.appendChild(fragment);

    // Update total display
    this.updateTotalDisplay(total);

    // Update form fields
    this.updateFormFields({
      total, 
      size: totalSize, 
      quantity: totalQuantity, 
      names: itemNames, 
      products: itemProducts, 
      colors: itemColors
    });
  }

  updateTotalDisplay(total) {
    const totalElements = [
      document.getElementById("total"), 
      document.getElementById("order_total")
    ];

    totalElements.forEach(element => {
      if (element) {
        element.value = `₱${total.toFixed(2)}`;
        element.innerText = `Total: ₱${total.toFixed(2)}`;
      } else {
        console.warn("Total display element not found");
      }
    });
  }

  updateFormFields({ total, size, quantity, names, products, colors }) {
    const fields = [
      { 
        id: "order_size", 
        value: size 
      },
      { 
        id: "order_quantity", 
        value: quantity 
      },
      { 
        id: "order_items", 
        value: [
          `Names: ${names.join(", ")}`,
          `Products: ${products.join(", ")}`,
          `Colors: ${colors.join(", ")}`
        ].join(" | ")
      }
    ];

    fields.forEach(field => {
      const element = document.getElementById(field.id);
      if (element) {
        element.value = field.value;
      } else {
        console.warn(`Field not found: ${field.id}`);
      }
    });
  }
 
  clear() {
    localStorage.removeItem("cart");
    window.location.reload();
  }

  removeFromCart(event) {
    try {
      const cart = JSON.parse(localStorage.getItem("cart") || '[]');
      const { id, size } = JSON.parse(event.target.value);
      
      const filteredCart = cart.filter(item => 
        !(item.id === id && item.size === size)
      );

      localStorage.setItem("cart", JSON.stringify(filteredCart));
      window.location.reload();
    } catch (error) {
      console.error("Error removing item from cart", error);
    }
  }

  checkout(event) {
    event.preventDefault();
    window.location.href = "/customer_orders/new";
  }
}