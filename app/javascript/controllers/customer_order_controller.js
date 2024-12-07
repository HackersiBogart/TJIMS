import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["product", "paintColor"];

  initialize() {
    console.log("Customer Order controller initialized");

  }

  connect() {
    console.log("Customer Order controller connected");
  }



  updateProducts(event) {
    const colorId = event.target.value;
    if (!colorId) return;

    fetch(`/colors/${colorId}/products`)
      .then((response) => response.json())
      .then((data) => {
        this.productTarget.innerHTML = '<option value="">Choose a product</option>';
        data.products.forEach((product) => {
          const option = document.createElement("option");
          option.value = product.id;
          option.textContent = product.name;
          this.productTarget.appendChild(option);
        });
      });
  }

  updatePaintColors(event) {
    const productId = event.target.value;
    if (!productId) return;

    fetch(`/products/${productId}/paint_colors`)
      .then((response) => response.json())
      .then((data) => {
        this.paintColorTarget.innerHTML = '<option value="">Choose a paint color</option>';
        data.paint_colors.forEach((paintColor) => {
          const option = document.createElement("option");
          option.value = paintColor.id;
          option.textContent = paintColor.name;
          this.paintColorTarget.appendChild(option);
        });
      });
  }
}
