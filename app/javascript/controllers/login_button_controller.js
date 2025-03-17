import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button", "spinner"]

  submit(event) {
    // Desativa o botão e mostra o spinner
    this.buttonTarget.disabled = true
    this.spinnerTarget.classList.remove("d-none")
  }
}
