import { Controller } from "@hotwired/stimulus";
import { Chart, registerables } from "chart.js";

Chart.register(...registerables);

// Connects to data-controller="dashboard"
export default class extends Controller {
  static values = { revenue: Array }

  initialize() {
    // Debug log
    console.log("Revenue data:", this.revenueValue);

    // Ensure there is data to display
    if (!Array.isArray(this.revenueValue) || this.revenueValue.length === 0) {
      console.warn("Revenue data is empty or not an array.");
      return;
    }

    // Extract labels and data from revenueValue
    const labels = this.revenueValue.map(item => item[0]);
    const data = this.revenueValue.map(item => item[1]);

    // Schedule the chart creation on the next frame
    requestAnimationFrame(() => this.createChart(labels, data));
  }

  createChart(labels, data) {
    const ctx = document.getElementById("revenueChart");
    if (!ctx) {
      console.warn("Canvas element for the chart not found!");
      return;
    }

    // If a chart already exists, destroy it before creating a new one
    if (ctx.chart) {
      ctx.chart.destroy();
    }

    // Create a new line chart
    ctx.chart = new Chart(ctx, {
      type: "line",
      data: {
        labels: labels,
        datasets: [{
          label: "Revenue ₱",
          data: data,
          borderColor: "#4caf50", // Example color for line
          backgroundColor: "rgba(76, 175, 80, 0.2)", // Transparent fill
          borderWidth: 3,
          fill: true,
          tension: 0.3 // Smooth line
        }]
      },
      options: {
        plugins: {
          legend: {
            display: false
          }
        },
        scales: {
          x: {
            grid: {
              display: false
            }
          },
          y: {
            ticks: {
              callback: function (value) {
                return `₱${value.toLocaleString()}`;
              }
            },
            grid: {
              color: "#d4f3ef"
            },
            beginAtZero: true
          }
        },
        responsive: true,
        maintainAspectRatio: false
      }
    });
  }
}
