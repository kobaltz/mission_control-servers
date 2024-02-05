import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    src: String,
    interval: 60000
  }

  static targets = ["progressBar"]

  connect() {
    this.startRefreshProcess()
    if (this.hasProgressBarTarget) {
      this.resetProgressBar()
    } else {
      setTimeout(() => {
        this.resetProgressBar()
      }, 500)
    }
  }

  disconnect() {
    this.stopRefreshProcess()
  }

  startRefreshProcess() {
    this.intervalId = setInterval(() => {
      this.refreshContent()
    }, this.intervalValue)
  }

  stopRefreshProcess() {
    clearInterval(this.intervalId)
    clearInterval(this.countdownId)
  }

  refreshContent() {
    if (this.element.src) {
      this.element.reload()
    } else {
      this.element.setAttribute('src', this.srcValue)
    }
    this.resetProgressBar()
  }

  startProgressBar() {
    let percentage = 100
    this.progressBarTarget.style.width = `${percentage}%`

    const countdown = () => {
      percentage -= 100 / (this.intervalValue / 500)
      this.progressBarTarget.style.width = `${percentage}%`

      if (percentage <= 0) {
        clearInterval(this.countdownId)
      }
    }

    this.countdownId = setInterval(countdown, 500)
  }

  resetProgressBar() {
    clearInterval(this.countdownId)
    this.startProgressBar()
  }
}
