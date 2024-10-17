// app/javascript/controllers/mixture_controller.js
import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["orderSelect", "referenceImage"];

  connect() {
    // Automatically invoked when the controller is connected
  }

  changeOrder() {
    const selectedOrderId = this.orderSelectTarget.value;

    if (selectedOrderId) {
      // Fetch the reference image URL via AJAX or a JSON endpoint
      fetch(`/admin/orders/${selectedOrderId}/reference_image`)
        .then(response => response.json())
        .then(data => {
          // Update the reference image source with the fetched URL
          this.referenceImageTarget.src = data.image_url || "https://via.placeholder.com/100";
        })
        .catch(() => {
          // If an error occurs, fallback to a placeholder
          this.referenceImageTarget.src = "https://via.placeholder.com/100";
        });
    } else {
      // Reset to the default placeholder if no order is selected
      this.referenceImageTarget.src = "https://via.placeholder.com/100";
    }
  }
}
