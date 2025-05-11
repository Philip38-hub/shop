import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["notice"]

  connect() {
    if (this.hasNoticeTarget) {
      // Add delete button
      const deleteButton = document.createElement('button')
      deleteButton.className = 'delete'
      deleteButton.addEventListener('click', () => this.dismiss())
      this.noticeTarget.insertBefore(deleteButton, this.noticeTarget.firstChild)
      
      // Auto dismiss
      this.autoDismiss()
    }
  }

  dismiss() {
    this.noticeTarget.style.transition = "opacity 0.5s ease-out"
    this.noticeTarget.style.opacity = 0
    
    setTimeout(() => {
      this.noticeTarget.remove()
    }, 500)
  }

  autoDismiss() {
    setTimeout(() => {
      this.dismiss()
    }, 3000)
  }
}
