import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["source"];

  copy(event) {
    const text = this.sourceTarget.textContent;
    navigator.clipboard.writeText(text).then(() => {
      event.target.textContent = "Copied!";
    }).catch(err => {
      console.error('Failed to copy text: ', err);
    });
  }
}
