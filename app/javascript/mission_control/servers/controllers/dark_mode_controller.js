import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.toggleDarkMode();
  }

  toggleDarkMode() {
    if (localStorage.getItem('darkMode') === 'true') {
      document.documentElement.classList.add('dark');
    } else {
      document.documentElement.classList.remove('dark');
    }
  }

  toggle() {
    let htmlClasses = document.documentElement.classList;
    if (htmlClasses.contains('dark')) {
      htmlClasses.remove('dark');
      localStorage.setItem('darkMode', 'false');
    } else {
      htmlClasses.add('dark');
      localStorage.setItem('darkMode', 'true');
    }
  }
}
