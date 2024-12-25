import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["recipe", "ingredient", "tag", "button"];

  showSection(event) {
    event.preventDefault();
    const section = event.currentTarget.dataset.section;
    this.hideAllSections();
    this[section + "Target"].classList.remove("hidden");
    this.setActiveButton(event.currentTarget);
  }

  hideAllSections() {
    this.recipeTarget.classList.add("hidden");
    this.ingredientTarget.classList.add("hidden");
    this.tagTarget.classList.add("hidden");
  }

  setActiveButton(activeButton) {
    this.buttonTargets.forEach((button) => {
      // Удаляем классы подчеркивания и активного состояния у всех кнопок
      button.classList.remove("text-gray-900", "border-gray-900");
      button.classList.add("text-gray-500", "border-transparent");
      button.setAttribute("aria-selected", "false");
  });

  // Добавляем классы подчеркивания и активного состояния только для выбранной кнопки
  activeButton.classList.add("text-gray-900", "border-gray-900");
  activeButton.classList.remove("text-gray-500", "border-transparent");
  activeButton.setAttribute("aria-selected", "true");
  }
}
