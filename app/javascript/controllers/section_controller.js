import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["recipe", "ingredient", "tag"];

  showSection(event) {
    const section = event.currentTarget.dataset.section; // Получаем значение из data-section
    this.hideAllSections();
    this[section + "Target"].classList.remove("hidden");
  }

  hideAllSections() {
    this.recipeTarget.classList.add("hidden");
    this.ingredientTarget.classList.add("hidden");
    this.tagTarget.classList.add("hidden");
  }
}
