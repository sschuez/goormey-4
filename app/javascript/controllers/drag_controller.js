import { Controller } from "@hotwired/stimulus"
import Rails from "@rails/ujs"
import { Sortable } from "sortablejs"

export default class extends Controller {

  connect() {
    this.sortable = Sortable.create(this.element, {
      animation: 150,
      handle: ".handle",
      onEnd: this.end.bind(this),
    });
  }

  countElements() {
  }

  end(event) {
    let id = event.item.dataset.id
    // console.log(event.item.dataset)

    let url = this.data.get("url")
    url = url.replace(":id", id)
    // console.log(url)
    
    let data = new FormData()
    data.append("position", event.newIndex + 1)
    // console.log(event)

    Rails.ajax({
      url: url,
      type: "PATCH",
      data: data,
    });
  }
}