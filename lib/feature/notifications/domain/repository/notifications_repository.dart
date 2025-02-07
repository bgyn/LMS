import 'package:fpdart/fpdart.dart';
import 'package:lms/core/faliure/faliure.dart';
import 'package:lms/feature/notifications/domain/model/notification_model.dart';

abstract class NotificationRepository {
  Future<Either<Failure, List<NotificationModel>>> fetchNotification();
  Future<Either<Failure, void>> markAsRead({String? id});
}
