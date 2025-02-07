sealed class NotificationEvent {}

class GetNotification extends NotificationEvent {}

class MarkAsReadNotification extends NotificationEvent {
  final String id;
  MarkAsReadNotification(this.id);
}

class MarkAllAsReadNotification extends NotificationEvent {}
