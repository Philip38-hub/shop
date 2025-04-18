document.addEventListener('turbolinks:load', () => {
  const dismissNotification = (notification) => {
    // Skip if already being dismissed
    if (notification.dataset.dismissing) return;
    notification.dataset.dismissing = 'true';

    // Fade out
    notification.style.opacity = '0';
    notification.style.transition = 'opacity 1s ease-out';

    // Remove after animation
    setTimeout(() => {
      notification.remove();
    }, 1000);
  };

  const setupNotifications = () => {
    const notifications = document.querySelectorAll('.notification.global-notification');
    notifications.forEach(notification => {
      // Skip if already handled
      if (notification.dataset.handled) return;
      notification.dataset.handled = 'true';

      // Add close button
      const closeButton = document.createElement('button');
      closeButton.className = 'delete';
      closeButton.addEventListener('click', () => dismissNotification(notification));
      notification.insertBefore(closeButton, notification.firstChild);

      // Auto dismiss after 3 seconds
      setTimeout(() => dismissNotification(notification), 3000);
    });
  };

  // Initial setup
  setupNotifications();

  // Setup for dynamically added notifications
  const observer = new MutationObserver((mutations) => {
    mutations.forEach((mutation) => {
      if (mutation.addedNodes.length) {
        setupNotifications();
      }
    });
  });

  // Observe the body for added notifications
  observer.observe(document.body, {
    childList: true,
    subtree: true
  });
});
