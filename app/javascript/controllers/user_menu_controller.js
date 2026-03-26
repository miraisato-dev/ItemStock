// app/javascript/controllers/app/javascript/controllers/user_menu_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    const wrapper = this.element
    const button = wrapper.querySelector(".user-menu-toggle")

    if (button) {
      button.addEventListener("click", (e) => {
        e.stopPropagation()
        wrapper.classList.toggle("active")
      })
    }

    document.addEventListener("click", () => {
      document.querySelectorAll(".user-menu.active").forEach((w) => {
        w.classList.remove("active")
      })
    })
  }
}