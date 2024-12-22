import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  disconnect() {
    this.element.classList.add('disabled');
    this.element.setAttribute('aria-disabled', 'true');
    this.element.style.pointerEvents = 'none';
  }

  handleClick(event) {
    this.disconnect();
  }
}
