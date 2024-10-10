import { Controller } from "@hotwired/stimulus"
import {Chart, registerables } from 'chart.js'

Chart.register(...registerables)

// Connects to data-controller="dashboard"
export default class extends Controller {
  static values = { revenue: Array }

  initialize() {
    console.log('Revenue data:', this.revenueValue); // Debug log
  
    const data = this.revenueValue.map((item) => item[1]);
    const labels = this.revenueValue.map((item) => item[0]);
  
    requestAnimationFrame(() => {
      const ctx = document.getElementById('revenueChart');
    
      if (ctx) {
        new Chart(ctx, {
          type: 'line',
          data: {
            labels: labels,
            datasets: [{
              label: 'Revenue ₱',
              data: data,
              borderWidth: 3,
              fill: true
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
                border: {
                  dash: [5, 5]
                },
                grid: {
                  color: "#d4f3ef"
                },
                beginAtZero: true
              }
            }
          }
        });
      } else {
        console.log('Canvas not found!');
      }
    });
  }
}  

