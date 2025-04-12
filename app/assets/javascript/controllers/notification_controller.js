import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["notice"]

  connect() {
    if (this.hasNoticeTarget && this.noticeTarget.textContent.trim() !== "") {
      this.autoDismiss()
    }
  }

  autoDismiss() {
    setTimeout(() => {
      this.noticeTarget.style.transition = "opacity 1s ease-out"
      this.noticeTarget.style.opacity = 0
      
      setTimeout(() => {
        this.noticeTarget.remove()
      }, 1000)
    }, 3000)
  }
}

// app/javascript/packs/cart.js
document.addEventListener('turbolinks:load', () => {
  // Handle Flash Messages
  const flashMessages = document.querySelectorAll('.notification:not(.is-permanent)');
  flashMessages.forEach(flash => {
    setTimeout(() => {
      flash.style.transition = 'opacity 1s ease';
      flash.style.opacity = 0;
      
      setTimeout(() => {
        flash.remove();
      }, 1000);
    }, 3000);
  });
});