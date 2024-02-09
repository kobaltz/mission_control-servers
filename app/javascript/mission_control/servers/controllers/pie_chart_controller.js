import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    label: "Chart",
    idle: Number,
    used: Number,
    idleLabel: String,
    usedLabel: String,
    idleColor: "rgb(235, 235, 235)",
    idleDarkColor: "rgb(32, 32, 32)",
    usedColor: "rgb(54, 162, 235)",
    usedDarkColor: "rgb(32, 32, 128)",
    darkBorderColor: "rgb(255, 255, 255, 0.1)",
    lightBorderColor: "rgb(0, 0, 0, 0.1)"
  }

  connect() {
    this.observeHtmlClassChanges();
    this.displayChart();
  }

  observeHtmlClassChanges() {
    const observer = new MutationObserver(mutations => {
      mutations.forEach(mutation => {
        if (mutation.type === "attributes" && mutation.attributeName === "class") {
          this.updateChartColors();
        }
      });
    });
    observer.observe(document.documentElement, { attributes: true });
  }

  updateChartColors() {
    const isDarkMode = document.documentElement.classList.contains('dark');
    const idleColor = isDarkMode ? this.idleDarkColorValue : this.idleColorValue;
    const usedColor = isDarkMode ? this.usedDarkColorValue : this.usedColorValue;
    this.chart.data.datasets.forEach(dataset => {
      dataset.backgroundColor = [usedColor, idleColor];
      dataset.borderColor = isDarkMode ? this.darkBorderColorValue : this.lightBorderColorValue;
    });
    this.chart.update();
  }

  displayChart() {
    const isDarkMode = document.documentElement.classList.contains('dark');
    const idleColor = isDarkMode ? this.idleDarkColorValue : this.idleColorValue;
    const usedColor = isDarkMode ? this.usedDarkColorValue : this.usedColorValue;
    this.chart = new Chart(this.element, {
      type: 'doughnut',
      data: {
        labels: [this.usedLabelValue, this.idleLabelValue],
        datasets: [{
          label: this.labelValue,
          data: [this.usedValue, this.idleValue],
          backgroundColor: [usedColor, idleColor],
          borderColor: isDarkMode ? this.darkBorderColorValue : this.lightBorderColorValue,
          hoverOffset: 4
        }]
      },
      options: { animation: false }
    });
  }
}
