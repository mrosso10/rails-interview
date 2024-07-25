import { Controller } from "@hotwired/stimulus"
import { patch } from '@rails/request.js'

// Connects to data-controller="form"
export default class extends Controller {
  submit() {
    const formData = new FormData(this.element)
    patch(this.element.action, { body: formData , responseKind: 'turbo-stream'})
  }
}
