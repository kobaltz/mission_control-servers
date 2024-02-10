import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["link", "content"]
  static values = { refreshInterval: 10000 }
  index = 0;

  connect() {
    this.showInitialTab();
    this.loopThroughTabs();
  }

  showInitialTab() {
    const initialTab = this.linkTargets[0];
    if (initialTab) {
      this.showTab(initialTab.dataset.target);
    }
  }

  loopThroughTabs() {
    this.showTab(this.linkTargets[this.index].dataset.target);

    this.interval = setInterval(() => {
      this.index = (this.index + 1) % this.linkTargets.length;
      this.showTab(this.linkTargets[this.index].dataset.target);
    }, this.refreshIntervalValue);
  }

  showTab(targetId) {
    this.resetTabs();
    const activeTab = this.linkTargets.find(link => link.dataset.target === targetId);
    const activeContent = this.contentTargets.find(content => content.dataset.target === targetId);

    if (activeTab && activeContent) {
      activeTab.classList.add("text-xl", "text-gray-100", 'bg-indigo-500', 'dark:bg-indigo-900', 'transition', 'duration-300', 'ease-in-out');

      activeContent.classList.remove('absolute', 'top-0', 'left-full', 'w-0', 'h-0');
      activeContent.classList.add('relative');
    }
  }

  resetTabs() {
    this.linkTargets.forEach(link => {
      link.classList.add('transition', 'duration-300', 'ease-in-out');
      link.classList.remove("text-xl", "text-gray-100", 'bg-indigo-500', "dark:bg-indigo-900");
    });
    this.contentTargets.forEach(content => {
      content.classList.add('absolute', 'top-0', 'left-full', 'w-0', 'h-0');
      content.classList.remove('relative');
    });
  }


  changeTab(event) {
    event.preventDefault();
    const targetId = event.target.dataset.target;
    const newIndex = this.linkTargets.findIndex(link => link.dataset.target === targetId);
    if (newIndex >= 0) {
      this.index = newIndex;
    }
    this.showTab(targetId);

    clearInterval(this.interval);
    this.loopThroughTabs();
  }

  disconnect() {
    clearInterval(this.interval);
  }

}
