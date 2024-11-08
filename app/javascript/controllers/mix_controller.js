import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["colorsContainer"];

  initialize() {
    this.colorIndex = 0; // Initialize color index
  }

  addColorField() {
    // Create a new div to hold the new color fields
    const newColorFields = document.createElement("div");
    newColorFields.classList.add("color-fields", "my-5", "relative", "p-4", "border", "border-gray-300", "rounded-md");

    // Dynamically generate the options for the primary colors
    const options = primaryColors.map(color => 
      `<option value="${color.id}">${color.color_name}</option>`
    ).join('');

    // Set the inner HTML of the newColorFields to include the select input and the amount input
    newColorFields.innerHTML = `
      <label>Primary Color</label>
      <select name="primary_colors[${this.colorIndex}][primary_color_id]" class="block shadow rounded-md border border-gray-400 outline-none px-3 py-2 mt-2 w-full">
        <option value="">Choose a Primary Color</option>
        ${options}
      </select>

      <label>Amount to Deduct</label>
      <input type="number" step="0.01" name="primary_colors[${this.colorIndex}][amount]" class="block shadow rounded-md border border-gray-400 outline-none px-3 py-2 mt-2 w-full">

      <button type="button" class="remove-color bg-red-500 text-white px-3 py-2 rounded-md" style="position: absolute; top: 10px; right: 10px;">
          Remove
      </button>
    `;

    // Append the new fields to the container
    this.colorsContainerTarget.appendChild(newColorFields);

    // Add event listener to the remove button
    newColorFields.querySelector(".remove-color").addEventListener("click", () => {
      this.colorsContainerTarget.removeChild(newColorFields);
    });

    this.colorIndex++; // Increment the index for the next added color
  }
}
