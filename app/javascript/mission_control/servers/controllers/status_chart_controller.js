import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    data: String,
    darkBorderColor: "rgb(255, 255, 255, 0.1)",
    lightBorderColor: "rgb(0, 0, 0, 0.1)"
  }

  connect() {
    this.observeHtmlClassChanges()
    this.values = JSON.parse(this.dataValue)
    this.displayChart()
  }

  observeHtmlClassChanges() {
    const observer = new MutationObserver(mutations => {
      mutations.forEach(mutation => {
        if (mutation.type === "attributes" && mutation.attributeName === "class") {
          this.updateChartColors()
        }
      })
    })
    observer.observe(document.documentElement, { attributes: true })
  }

  updateChartColors() {
    const isDarkMode = document.documentElement.classList.contains('dark')
    const borderColor = isDarkMode ? this.darkBorderColorValue : this.lightBorderColorValue
    const backgroundColors = isDarkMode ? this.darkModeBackgroundColors() : this.lightModeBackgroundColors()

    this.chart.data.datasets.forEach(dataset => {
      dataset.borderColor = borderColor
      dataset.backgroundColor = backgroundColors
    })
    this.chart.update()
  }

  darkModeBackgroundColors() {
    return [
      "rgb(45, 167, 167)",
      "rgb(204, 175, 55)",
      "rgb(204, 85, 0)",
      "rgb(150, 75, 75)",
      "rgb(85, 85, 255)"
    ]
  }

  lightModeBackgroundColors() {
    return [
      "rgb(75, 192, 192)",
      "rgb(255, 159, 64)",
      "rgb(255, 99, 132)",
      "rgb(153, 102, 255)",
      "rgb(54, 162, 235)"
    ]
  }


  displayChart() {
    const isDarkMode = document.documentElement.classList.contains('dark')
    const backgroundColors = isDarkMode ? this.darkModeBackgroundColors() : this.lightModeBackgroundColors()
    const borderColor = isDarkMode ? this.darkBorderColorValue : this.lightBorderColorValue

    this.chart = new Chart(this.element, {
      type: 'doughnut',
      data: {
        labels: ['2xx', '3xx', '4xx', '5xx', 'Unknown'],
        datasets: [{
          data: [
            this.values.sum_2xx,
            this.values.sum_3xx,
            this.values.sum_4xx,
            this.values.sum_5xx,
            this.values.unknown
          ],
          backgroundColor: backgroundColors,
          borderColor: borderColor,
          borderWidth: 1,
          hoverOffset: 4
        }]
      },
      options: {
        responsive: true,
        plugins: {
          legend: {
            position: 'top',
          },
          title: {
            display: true,
            text: 'HTTP Status Codes Distribution'
          }
        }
      }
    })
  }
}
