import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input"]

  connect() {
    console.log("Hostname select controller connected");
  }

  copy(event) {
    event.preventDefault();

    const hostnameElement = event.target.closest('li').querySelector('[data-target="hostname"]');

    if (hostnameElement) {
      this.inputTarget.value = hostnameElement.textContent.trim();
    }
  }
}
