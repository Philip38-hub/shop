import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["notice"]

  connect() {
    if (this.hasNoticeTarget && this.noticeTarget.textContent.trim() !== "") {
      this.autoDismiss()
    }
    
    // Handle all non-permanent flash messages
    const flashMessages = document.querySelectorAll('.notification:not(.is-permanent)');
    flashMessages.forEach(flash => {
      this.dismissElement(flash);
    });
  }

  autoDismiss() {
    this.dismissElement(this.noticeTarget);
  }
  
  dismissElement(element) {
    setTimeout(() => {
      element.style.transition = "opacity 0.5s ease-out"
      element.style.opacity = 0
      
      setTimeout(() => {
        element.remove()
      }, 500)
    }, 3000)
  }
}
