import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["notice"]

  connect() {
    console.log("[NotificationController] connect", this.noticeTargets)
    this.noticeTargets.forEach((notice, idx) => {
      console.log(`[NotificationController] Processing notice #${idx}`, notice)
      // Add delete button if not present
      if (!notice.querySelector('.delete')) {
        const deleteButton = document.createElement('button')
        deleteButton.className = 'delete'
        deleteButton.addEventListener('click', () => this.dismiss(notice))
        notice.insertBefore(deleteButton, notice.firstChild)
        console.log(`[NotificationController] Delete button added to notice #${idx}`)
      }
      // Auto dismiss each notification
      this.autoDismiss(notice, idx)
    })
  }

  dismiss(notice) {
    console.log("[NotificationController] Dismissing notice", notice)
    notice.style.transition = "opacity 0.5s ease-out"
    notice.style.opacity = 0
    setTimeout(() => {
      console.log("[NotificationController] Removing notice from DOM", notice)
      notice.remove()
    }, 500)
  }

  autoDismiss(notice, idx) {
    console.log(`[NotificationController] Setting auto-dismiss for notice #${idx}`)
    setTimeout(() => {
      this.dismiss(notice)
    }, 3000)
  }
}
