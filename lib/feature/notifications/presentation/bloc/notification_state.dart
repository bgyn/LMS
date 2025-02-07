import 'package:lms/feature/notifications/domain/model/notification_model.dart';

sealed class NotificationState {
  final List<NotificationModel>? notifications;
  final String? error;
  NotificationState({this.notifications, this.error});
}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationLoaded extends NotificationState {
  final List<NotificationModel> notification;
  NotificationLoaded(this.notification) : super(notifications: notification);
}

class NotificationError extends NotificationState {}
