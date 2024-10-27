
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    console.log("Button controller connected");
  }

  preMade() {
    alert("Pre-Made button clicked");
  }

  toMix() {
    alert("To Mix button clicked");
  }
}
