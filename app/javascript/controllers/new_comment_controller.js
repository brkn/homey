import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.element.addEventListener('keydown', this.handleKeyDown.bind(this))
  }

  disconnect() {
    this.element.removeEventListener('keydown', this.handleKeyDown.bind(this))
  }

  handleKeyDown(event) {
    if (event.key === 'Enter' && (event.metaKey || event.ctrlKey)) {
      event.preventDefault()
      this.element.requestSubmit()
    }
  }

  reset() {
    this.element.reset()
  }
}
