import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/core/utils/show_snackbar.dart';
import 'package:lms/feature/notifications/domain/usecase/fetch_notification.dart';
import 'package:lms/feature/notifications/domain/usecase/mark_all_as_read.dart';
import 'package:lms/feature/notifications/domain/usecase/mark_as_read.dart';
import 'package:lms/feature/notifications/presentation/bloc/notification_event.dart';
import 'package:lms/feature/notifications/presentation/bloc/notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final FetchNotification _fetchNotification;
  final MarkAsRead _markAsRead;
  final MarkAllAsRead _markAllAsRead;
  NotificationBloc(
      {required FetchNotification fetchNotification,
      required MarkAsRead markAsRead,
      required MarkAllAsRead markAllAsRead})
      : _fetchNotification = fetchNotification,
        _markAllAsRead = markAllAsRead,
        _markAsRead = markAsRead,
        super(NotificationInitial()) {
    on<GetNotification>(_onFetchNotification);
    on<MarkAllAsReadNotification>(_onMarkAllAsReadNotification);
    on<MarkAsReadNotification>(_onMarkAsReadNotification);
  }

  void _onFetchNotification(
      GetNotification event, Emitter<NotificationState> emit) async {
    final result = await _fetchNotification(null);
    result.fold((l) {
      showSnackbar(l.errorMessage);
      emit(NotificationError());
    }, (r) => emit(NotificationLoaded(r)));
  }

  void _onMarkAllAsReadNotification(
      MarkAllAsReadNotification event, Emitter<NotificationState> emit) async {
    final result = await _markAllAsRead(null);
    result.fold((l) {
      showSnackbar(l.errorMessage);
    }, (r) {
      final newState = state.notifications!
          .map((notification) => notification.copyWith(isRead: true))
          .toList();
      emit(NotificationLoaded(newState));
    });
  }

  void _onMarkAsReadNotification(
      MarkAsReadNotification event, Emitter<NotificationState> emit) async {
    final result = await _markAsRead(event.id);
    result.fold((l) {
      showSnackbar(l.errorMessage);
    }, (r) {
      final newState = state.notifications!
          .map((notification) => notification.id == event.id
              ? notification.copyWith(isRead: true)
              : notification)
          .toList();
      emit(NotificationLoaded(newState));
    });
  }
}
