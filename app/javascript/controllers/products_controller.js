import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="products"
export default class extends Controller {
  connect() {
  }
}

document.addEventListener("DOMContentLoaded", function() {
  const colorsContainer = document.getElementById("colors-container");
  let colorIndex = 1;

  document.getElementById("add-color").addEventListener("click", function() {
      const newColorFields = document.createElement("div");
      newColorFields.classList.add("color-fields", "my-5", "relative", "p-4", "border", "border-gray-300", "rounded-md");

      newColorFields.innerHTML = `
          <label>Color Name</label>
          <input type="text" name="admin_product[colors_attributes][${colorIndex}][name]" class="block shadow rounded-md border border-gray-400 outline-none px-3 py-2 mt-2 w-full" />

          <label>Color Code</label>
          <input type="text" name="admin_product[colors_attributes][${colorIndex}][code]" class="block shadow rounded-md border border-gray-400 outline-none px-3 py-2 mt-2 w-full" />

          <label>Color Image</label>
          <input type="file" name="admin_product[colors_attributes][${colorIndex}][image]" class="block shadow rounded-md border border-gray-400 outline-none px-3 py-2 mt-2 w-full" />

          <button type="button" class="remove-color bg-red-500 text-white px-3 py-2 rounded-md" style="position: absolute; top: 10px; right: 10px;">
              Remove
          </button>
      `;

      colorsContainer.appendChild(newColorFields);

      // Add event listener for the remove button
      newColorFields.querySelector(".remove-color").addEventListener("click", function() {
          colorsContainer.removeChild(newColorFields);
      });

      colorIndex++;
  });
});
