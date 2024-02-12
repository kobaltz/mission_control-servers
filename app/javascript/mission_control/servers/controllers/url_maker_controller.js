import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["dark", "combo", "interval", "link", "output"]


  connect() {
    this.originalUrl = this.linkTarget.href;
    console.log("URL Maker Controller connected");
    this.updateLink(); // Call on connect to set initial state if needed
  }

  updateLink() {
    const darkMode = this.darkTarget.checked ? "dark=true" : "dark=false";
    const disableCombo = this.comboTarget.checked ? "combo=false" : "combo=true";
    const interval = `interval=${this.intervalTarget.value}`;
    const newUrl = `${this.originalUrl}?${darkMode}&${disableCombo}&${interval}`;

    this.linkTarget.href = newUrl;
    this.outputTarget.textContent = newUrl;
  }
}
