import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.checkUrlForDarkMode();
    this.toggleDarkMode();
  }

  checkUrlForDarkMode() {
    const urlParams = new URLSearchParams(window.location.search);
    const dark = urlParams.get('dark');

    if (dark === 'true') {
      document.documentElement.classList.add('dark');
      localStorage.setItem('darkMode', 'true');
    } else if (dark === 'false') {
      document.documentElement.classList.remove('dark');
      localStorage.setItem('darkMode', 'false');
    }
  }

  toggleDarkMode() {
    if (localStorage.getItem('darkMode') === 'true') {
      document.documentElement.classList.add('dark');
      this.element.innerHTML = 'Light Mode';
    } else {
      document.documentElement.classList.remove('dark');
      this.element.innerHTML = 'Dark Mode';
    }
  }

  toggle() {
    let htmlClasses = document.documentElement.classList;
    if (htmlClasses.contains('dark')) {
      htmlClasses.remove('dark');
      localStorage.setItem('darkMode', 'false');
      this.element.innerHTML = 'Dark Mode';
    } else {
      htmlClasses.add('dark');
      localStorage.setItem('darkMode', 'true');
      this.element.innerHTML = 'Light Mode';
    }
  }
}
