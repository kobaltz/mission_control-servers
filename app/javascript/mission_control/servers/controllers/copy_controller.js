import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["source"];

  copy(event) {
    event.preventDefault();
    const text = this.sourceTarget.textContent;
    const originalText = event.target.textContent;
    navigator.clipboard.writeText(text).then(() => {
      event.target.textContent = "Copied!";
      setTimeout(() => {
        event.target.textContent = originalText;
      }, 2000);
    }).catch(err => {
      console.error('Failed to copy text: ', err);
    });
  }
}
