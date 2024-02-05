import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["modal"]

  connect() {
    console.log("Modal controller connected");
  }

  show() {
    console.log("show()")
    this.modalTarget.classList.remove("hidden");
  }

  hide() {
    console.log("hide()")
    this.modalTarget.classList.add("hidden");
  }
}
