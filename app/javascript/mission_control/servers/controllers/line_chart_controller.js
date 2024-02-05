import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    label: "Chart",
    labelArray: Array,
    dataArray: Array,
    color: "rgb(54, 162, 235)"
  }
  connect() {
    new Chart(this.element, {
      type: 'line',
      data: {
        labels: this.labelArrayValue,
        datasets: [{
          label: this.labelValue,
          data: this.dataArrayValue,
          fill: true,
          borderColor: this.colorValue,
          tension: 0.25
        }]
      },
      options: {
        animation: false
      }
    });
  }

}
