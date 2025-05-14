import consumer from "./consumer";

consumer.subscriptions.create("NotificationsChannel", {
  received(data) {
    const notificationCount = document.getElementById("notification-count");
    
    if (notificationCount) {
      notificationCount.textContent = data.count; // Update unread count
      notificationCount.classList.remove("d-none"); // Show if hidden
    }

    // Optionally, you can add a toast or alert message for new notifications
    const notificationList = document.getElementById("notification-list");
    if (notificationList) {
      notificationList.innerHTML = data.html + notificationList.innerHTML;
    }
  }
});
