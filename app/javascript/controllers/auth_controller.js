import {Controller} from "@hotwired/stimulus"


export default class extends Controller {
  static values = {
    id: String
  }

  connect() {
    // console.log('-----', this.idValue)
  }
}
