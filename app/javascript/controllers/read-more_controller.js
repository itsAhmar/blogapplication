import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["description"];
  
  toggle() {
 		  this.descriptionTarget.textContent = this.data.get("my-value");
 		  // console.log()
	};
}