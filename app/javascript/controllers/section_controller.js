import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["recipe", "ingredient", "tag", "button"];

  connect() {
    this.showInitialSection();
  }

  showInitialSection() {
  }

  showSection(event) {
    event.preventDefault();
    this.showSectionFromButton(event.currentTarget);
  }

  showSectionFromButton(button) {
    const section = button.dataset.section;
    this.hideAllSections();
    this[section + "Target"].classList.remove("hidden");
    this.setActiveButton(button);
  }

  hideAllSections() {
    this.recipeTarget.classList.add("hidden");
    this.ingredientTarget.classList.add("hidden");
    this.tagTarget.classList.add("hidden");
  }

  setActiveButton(activeButton) {
    this.buttonTargets.forEach((button) => {
      button.classList.remove("bg-amber-600", "text-white", "hover:bg-stone-50", "hover:text-stone-900");
      button.classList.add("text-stone-700");
      button.setAttribute("aria-selected", "false");
    });

    activeButton.classList.add("bg-amber-600", "text-white");
    activeButton.classList.remove("text-stone-700", "hover:bg-stone-50", "hover:text-stone-900");
    activeButton.setAttribute("aria-selected", "true");
  }
}