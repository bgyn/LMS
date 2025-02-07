import 'package:fpdart/fpdart.dart';
import 'package:lms/core/faliure/faliure.dart';
import 'package:lms/core/usecase/usecase.dart';
import 'package:lms/feature/notifications/domain/model/notification_model.dart';
import 'package:lms/feature/notifications/domain/repository/notifications_repository.dart';

class FetchNotification extends UseCase<List<NotificationModel>, void> {
  final NotificationRepository _notificationRepository;
  FetchNotification(this._notificationRepository);
  @override
  Future<Either<Failure, List<NotificationModel>>> call(void params) async {
    return await _notificationRepository.fetchNotification();
  }
}
