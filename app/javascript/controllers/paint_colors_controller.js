document.addEventListener("DOMContentLoaded", function () {
  // Add to Cart button functionality
  const addToCartButton = document.querySelector("#add-to-cart");
  if (addToCartButton) {
    addToCartButton.addEventListener("click", function () {
      const paintColorId = this.dataset.paintColorId;
      const paintColorName = this.dataset.paintColorName;
      const paintColorCode = this.dataset.paintColorCode;
      const paintColorPrice = parseFloat(this.dataset.paintColorPrice);
      const selectedSize = document.querySelector("#size-select").value;
      const selectedUnit = document.querySelector("#unit-select").value;

      if (!selectedSize || !selectedUnit) {
        alert("Please select a size and unit before adding to the cart.");
        return;
      }

      const cart = localStorage.getItem("cart");
      let cartArray = cart ? JSON.parse(cart) : [];

      const foundIndex = cartArray.findIndex(
        (item) =>
          item.id === paintColorId &&
          item.size === selectedSize &&
          item.unit === selectedUnit
      );

      if (foundIndex >= 0) {
        // Update the quantity if the item already exists in the cart
        cartArray[foundIndex].quantity += 1;
      } else {
        // Add new item to the cart
        cartArray.push({
          id: paintColorId,
          name: paintColorName,
          code: paintColorCode,
          size: selectedSize,
          price: paintColorPrice,
          unit: selectedUnit,
          quantity: 1,
        });
      }

      // Save the updated cart to localStorage
      localStorage.setItem("cart", JSON.stringify(cartArray));

      alert(`${paintColorName} has been added to the cart!`);
    });
  }

  // Size selection logic
  const sizeSelect = document.querySelector("#size-select");
  if (sizeSelect) {
    sizeSelect.addEventListener("change", function (e) {
      const selectedSize = e.target.value;
      const selectedPrice = e.target.dataset.price;

      document.querySelector("#selected-size").innerText = `Selected Size: ${selectedSize}`;
      document.querySelector("#price-display").innerText = `₱${parseFloat(selectedPrice).toFixed(2)}`;
    });
  }

  // Unit selection logic
  const unitSelect = document.querySelector("#unit-select");
  if (unitSelect) {
    unitSelect.addEventListener("change", function (e) {
      const selectedUnit = e.target.value;

      document.querySelector("#selected-unit").innerText = `Selected Unit: ${selectedUnit}`;

      // Filter size options based on the selected unit
      const sizeOptions = sizeSelect.querySelectorAll("option");
      sizeOptions.forEach((option) => {
        if (option.dataset.unit === selectedUnit || option.value === "") {
          option.style.display = "block"; // Show matching sizes
        } else {
          option.style.display = "none"; // Hide non-matching sizes
        }
      });
    });
  }
});
