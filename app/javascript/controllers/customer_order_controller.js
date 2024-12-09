// app/javascript/controllers/customer_order_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["product", "paintColor"];

  updateProducts(event) {
    const colorId = event.target.value;

    fetch(`/customer_orders/fetch_products?color_id=${colorId}`)
      .then((response) => response.json())
      .then((products) => {
        const productDropdown = this.productTarget;
        productDropdown.innerHTML = '<option value="">Choose a product</option>';

        products.forEach((product) => {
          const option = document.createElement("option");
          option.value = product.id;
          option.textContent = product.name;
          productDropdown.appendChild(option);
        });

        // Clear dependent dropdown
        this.paintColorTarget.innerHTML =
          '<option value="">Choose a paint color</option>';
      });
  }

  updatePaintColors(event) {
    const productId = event.target.value;

    fetch(`/customer_orders/fetch_paint_colors?product_id=${productId}`)
      .then((response) => response.json())
      .then((paintColors) => {
        const paintColorDropdown = this.paintColorTarget;
        paintColorDropdown.innerHTML =
          '<option value="">Choose a paint color</option>';

        paintColors.forEach((paintColor) => {
          const option = document.createElement("option");
          option.value = paintColor.id;
          option.textContent = paintColor.name;
          paintColorDropdown.appendChild(option);
        });
      });
  }
}
