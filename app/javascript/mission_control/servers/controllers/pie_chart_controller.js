import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    label: "Chart",
    idle: Number,
    used: Number,
    idleLabel: String,
    usedLabel: String,
    idleColor: "rgb(235, 235, 235)",
    usedColor: "rgb(54, 162, 235)"
  }
  connect() {
    const ctx = this.element
    new Chart(ctx, {
      type: 'doughnut',
      data: {
        labels: [this.usedLabelValue, this.idleLabelValue],
        datasets: [
          {
            label: this.labelValue,
            data: [this.usedValue, this.idleValue],
            backgroundColor: [this.usedColorValue,this.idleColorValue],
            hoverOffset: 4
          }
        ]
      },
      options: { animation: false }
    });
  }

}
