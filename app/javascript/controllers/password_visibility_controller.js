import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["password"]

  toggle() {
    const type = this.passwordTarget.type === "password" ? "text" : "password"
    this.passwordTarget.type = type
  }
}
