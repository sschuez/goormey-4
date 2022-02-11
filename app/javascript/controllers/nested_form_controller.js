import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "links", "template", "description", "inputElement" ]
  
  connect() {
    // Assign 'position' to already created elements
    let i = 1
    this.inputElementTargets.forEach((element) => {
      if (element.querySelector('h4')) {
        element.querySelector('h4').innerHTML = i++
      }
    })
  }

  add_association(event) {
    event.preventDefault()
    
    var content = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, new Date().getTime())
    this.linksTarget.insertAdjacentHTML('beforebegin', content)

    // Assign 'position' to new newly created element
      const elements = this.inputElementTargets
      var newElement = elements[elements.length - 1]
      if (newElement.querySelector('h4')) newElement.querySelector('h4').innerHTML = elements.length
  }

  remove_association(event) {
    event.preventDefault()

    let wrapper = event.target.closest(".nested-fields")

    // New records are simply removed from the page
    if (wrapper.dataset.newRecord == "true") {
      wrapper.remove()

    // Existing records are hidden and flagged for deletion
    } else {
      wrapper.querySelector("input[name*='_destroy']").value = 1
      wrapper.style.display = 'none'
    }
  }

}
