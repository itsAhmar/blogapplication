import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["description", "toggleButton"];
  static values = { truncatedContent: String };

  connect() {
    this.truncatedContentValue = this.descriptionTarget.textContent.trim();
  }

  toggle() {
    if (this.descriptionTarget.textContent.trim() === this.truncatedContentValue) {
      this.descriptionTarget.textContent = this.data.get("my-value");
      this.toggleButtonTarget.textContent = "Read Less";
    } else {
      this.descriptionTarget.textContent = this.truncatedContentValue;
      this.toggleButtonTarget.textContent = "Read More";
    }
  }
}
