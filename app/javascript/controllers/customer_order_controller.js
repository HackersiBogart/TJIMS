import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["product", "paintColor"];  // Ensure 'product' is included here

  updateProducts(event) {
    const colorId = event.target.value;
    fetch(`/customer_orders/fetch_products?color_id=${colorId}`)
      .then(response => response.json())
      .then(products => {
        // Populate the product dropdown
        this.productTarget.innerHTML = products.map(product => 
          `<option value="${product.id}">${product.name}</option>`
        ).join('');
      });
  }

  updatePaintColors(event) {
    const productId = event.target.value;
    fetch(`/customer_orders/fetch_paint_colors?product_id=${productId}`)
      .then(response => response.json())
      .then(paintColors => {
        // Populate the paint color dropdown
        this.paintColorTarget.innerHTML = paintColors.map(paintColor => 
          `<option value="${paintColor.id}">${paintColor.name}</option>`
        ).join('');
      });
  }
}
