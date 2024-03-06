import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["list"];

  dp()
  {
      this.listTarget.style.display = this.listTarget.style.display === "block" ? "none" : "block"; 
  }
}



