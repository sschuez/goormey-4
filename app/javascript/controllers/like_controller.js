import { Controller } from "@hotwired/stimulus"
import Rails from "@rails/ujs"

export default class extends Controller {
  static targets = [ "heart" ]

  save(event){
    const heart = this.heartTarget.classList

    let url = this.data.get("url")
    let data = new FormData()
    
    if (heart.contains('far')) {
      // Toggle Like
      Rails.ajax({
        url: url,
        type: "POST",
        data: data,
        success: function(data) { 
          heart.replace('far', 'fas')
        },
        error: function(data) { 
          alert(data)
        },
      });
    } else {
      // Toggle Unlike
      confirm("Are you sure you want to remove this recipe from your favourites?")
      Rails.ajax({
        url: url,
        type: "DELETE",
        data: data,
        success: function(data) { 
          heart.replace('fas', 'far')
        },
        error: function(data) { 
          alert(data)
        },
      });
    }
    
  }
  
  
}