import {Controller} from "@hotwired/stimulus"


export default class extends Controller {
  connect() {
    this.checkbox = this.element.querySelector('input#user_work_time')
    this.select = this.element.querySelector('select#user_work_time')

    if (this.checkbox && this.select) {
      this.select.disabled = this.checkbox.checked
      this.checkbox.onchange = (e) => {
        this.select.disabled = e.target.checked
      }
    }
  }
}
